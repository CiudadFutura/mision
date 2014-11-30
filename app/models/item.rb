class Item
  attr_reader :producto, :cantidad

  def initialize(producto, cantidad)
    @producto = producto || fail('Producto no definido')
    @cantidad = cantidad.to_f
    fail('Debe proveer una cantidad') if @cantidad <= 0
  end

  def ahorro
    return 0 if @producto.precio_super.nil? || @producto.precio_super == 0
    @cantidad * ((@producto.precio_super - @producto.precio) / @producto.precio)
  end

  def total
    @cantidad * @producto.precio
  end

  def to_json
    { producto_id: @producto.id, cantidad: @cantidad }
  end
end
