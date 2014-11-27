class Cart
  attr_reader :items

  def initialize(session)
    @session = session
    @session[:items] ||= {}
    load!
  end

  def load!
    @items = {}
    Rails.logger.debug ">>>>>>>>>>>> #{@session[:items]}"
    @session[:items].each do |producto_id, cantidad|
      Rails.logger.debug "#{producto_id}, #{cantidad}"
      @items[producto_id] = Item.new(
                  Producto.find_by_id(producto_id),
                  cantidad
                )
    end
    Rails.logger.debug ">>>>>>>>>>>>"
    Rails.logger.debug ">>>>>>>>>>>> #{@items}"
    Rails.logger.debug ">>>>>>>>>>>>"
  end

  def empty!
    @session[:items] = {}
    load!
  end

  def empty?
    @session[:items].empty?
  end

  def add(producto_id, cantidad)
    Rails.logger.debug ">>>>>>>>>>>> #{cantidad}!!!"
    @session[:items][producto_id] = cantidad
    load!
  end

  def remove(producto_id)
    @session[:items].delete(producto_id)
    load!
  end

  def cantidad
    total = 0.0
    @items.each do |_k, v|
      Rails.logger.debug(v)
      total += v.cantidad || 0
    end
    total
  end

  def ahorro
    total = 0.0
    @items.each do |_k, v|
      total += v.ahorro || 0
    end
    total
  end

  def total
    total = 0.0
    @items.each do |_k, v|
      total += v.total || 0
    end
    total
  end

  def to_json
    { cantidad: cantidad,
      ahorro: ahorro,
      total: total }.to_json
  end
end
