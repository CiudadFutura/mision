require 'open-uri'
require 'cgi'

class Supplier < ActiveRecord::Base
  enum nature: [:wholesaler, :retailer, :cooperative, :associative, :family]

  before_save :geocode_with_cache

  def minimal_clean_address
    [calle,ciudad,codigo_postal,'AR'].to_a.compact.join(",")
  end

  def api_url
    "http://maps.googleapis.com/maps/api/geocode/xml?"
  end

  def api_query
    URI.encode("#{api_url}address=#{minimal_clean_address}")
  end

  def geocode
    open(api_query) do |file|
      @body = file.read
      doc = Nokogiri(@body)
      parse_response(doc)
    end
  end

  def parse_response(doc)
    self.error_code = (doc/:status).first.inner_html
    if error_code.eql? "OK"
      set_coordinates(doc)
    end
  end

  def set_coordinates(doc)
    self.latitude = (doc/:geometry/:location/:lat).first.inner_html
    self.longitude = (doc/:geometry/:location/:lng).first.inner_html
  end

  def complete_address(doc)
    (doc/:result/:address_component).each do |ac|
      if (ac/:type).first.inner_html == "sublocality"
        self.ciudad = (ac/:long_name).first.inner_html
      end
    end
  end

  def geocode_with_cache
    c_address = address_lookup
    if c_address
      copy_cached_data(c_address)
    else
      geocode
    end
  end

  def address_lookup
    Supplier.where(cache_query).last
  end

  def cache_query
    ["calle = ? AND ciudad = ? and codigo_postal = ?",calle,ciudad,codigo_postal]
  end

  def copy_cached_data(ca)
    self.latitude = ca.latitude
    self.longitude = ca.longitude
    self.ciudad = ca.ciudad
    self.pais = ca.pais
  end

end
