class Cart
  attr_reader :productos

  def initialize(session)
    @session = session
    @session[:product_ids] ||= []
    load!
  end

  def load!
    @productos = Producto.find(@session[:product_ids]) || []
  end

  def empty!
    @session[:product_ids] = []
    load!
  end

  def empty?
    @productos.empty?
  end

  def add(producto_id)
    @session[:product_ids] << producto_id
    load!
  end

  def remove(producto_id)
    @session[:product_ids].delete(producto_id)
    load!
  end

  def cantidad
    @productos.count
  end

  def ahorro
    Rails.logger.debug @productos
    Rails.logger.debug @productos.map(&:ahorro)
    @productos.map(&:ahorro).inject(0, &:+)
  end

  def total
    @productos.map(&:precio).inject(0, &:+)
  end

  def to_json
    { cantidad: cantidad,
      ahorro: ahorro,
      total: total }.to_json
  end
end
