class CartsProduct < ActiveRecord::Base
	belongs_to :cart

=begin
	def initialize(producto, cantidad)
		@producto = producto || fail('Producto no definido')
		@cantidad = cantidad.to_f
		fail('Debe proveer una cantidad') if @cantidad <= 0
	end
=end

	def ahorro
		return 0 if @producto.precio_super.nil? || @producto.precio_super == 0
		(1 - (@producto.precio / @producto.precio_super)).to_f * 100
	end

	def total
		@cantidad * @producto.precio
	end

	def check_stock
		if @producto.stock.present?
			return @producto if @producto.stock < @cantidad
		end
	end

	def discount_qty_stock
		if @producto.stock.present?
			producto = Producto.find(@producto.id)
			producto.stock -= @cantidad
			if producto.stock == 0
				producto.oculto = true
			end
			producto.save
		end
	end

	def total_super
		return 0 if @producto.precio_super.nil? || @producto.precio_super == 0
		@cantidad * @producto.precio_super
	end

	def to_json
		{ producto_id: @producto.id,
			cantidad: @cantidad,
			removeUrl: remove_from_cart_path(@producto.id) }
	end

	def purchase_data
		{
				producto_id: @producto.id,
				cantidad: @cantidad,
				total: total,
		}
	end

end