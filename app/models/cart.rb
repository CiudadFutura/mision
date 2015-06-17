include ActionView::Helpers::NumberHelper
include ActionView::Helpers::TextHelper

class Cart
  attr_reader :items

  def initialize(session)
    @session = session
    @session[:items] ||= {}
    load!
  end

  def load!
    @items = {}
    @session[:items].each do |producto_id, cantidad|
      @items[producto_id] = Item.new(
                  Producto.find_by_id(producto_id),
                  cantidad
                )
    end
  end

  def empty!
    @session[:items] = {}
    load!
  end

  def empty?
    @session[:items].empty?
  end

  def add(producto_id, cantidad)
    @session[:items][producto_id] = cantidad
    load!
  end

  def remove(producto_id)
    @session[:items].delete(producto_id)
    load!
  end

  def producto?(producto_id)
    @items.key?(producto_id.to_s)
  end

  def cantidad
    total = 0.0
    @items.each do |_k, v|
      Rails.logger.debug(v)
      total += v.cantidad || 0
    end
    total.to_i
  end

  def ahorro
    total = 0.0
    @items.each do |_k, v|
      total += v.ahorro || 0
    end
    total.to_f
  end

  def total
    total = 0.0
    @items.each do |_k, v|
      total += v.total || 0
    end
    total.to_f
  end

  def formated_total
    ActionView::Helpers::NumberHelper.number_to_currency(total)
  end

  def formated_cantidad
    pluralize(cantidad, ' producto', ' productos')
  end

  def to_json
    { cantidad: formated_cantidad,
      ahorro: ahorro,
      total: formated_total }.to_json
  end
end
