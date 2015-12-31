require 'csv'
require 'open-uri'
require 'cgi'
require 'nokogiri'

class Usuario < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :confirmable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :circulo
  has_many :pedidos

  has_paper_trail

  before_create :set_default_role
  before_save :geocode_with_cache

  ADMIN = 'Admin'
  COORDINADOR = 'Coordinador'
  USUARIO = 'Usuario'

  def nombre
    super.nil? ? '' : super
  end

  def apellido
    super.nil? ? '' : super
  end

  def nombre_completo
    "#{apellido}, #{nombre}"
  end

  def self.types
    [ADMIN, COORDINADOR, USUARIO]
  end

  def admin?
    type == ADMIN
  end

  def coordinador?
    type == COORDINADOR
  end

  def usuario?
    type == USUARIO
  end

  def pedido?(ciclo_de_compra)
    ciclo_de_compra && self.pedidos.try(:last).try(:ciclo) == ciclo_de_compra
  end

  def pedido_del_ciclo(ciclo_de_compra)
    return nil if ciclo_de_compra.nil?
    pedido = self.pedidos.where(compra_id: ciclo_de_compra.id).first
    return pedido if pedido
    nil
  end

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
      if (ac/:type).first.inner_html == "administrative_area_level_3"
        self.pais = (ac/:long_name).first.inner_html
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
    Usuario.where(cache_query).last
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

  def self.to_csv
    CSV.generate do |csv|
      csv << ['Usuario Nro', 'Apellido y Nombre', 'Email', 'Circulo Nro']
      all.each do |usuario|
        csv << [
          usuario.id,
          "#{usuario.apellido}, #{usuario.nombre}",
          usuario.email,
          usuario.try('circulo').try('id') || "sin circulo"
        ]
      end
    end
  end

  private
  def set_default_role
    self.type ||= Usuario::USUARIO
  end

end
