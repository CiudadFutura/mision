class Remito
	attr_accessor :pedido, :usuario, :producto

	def initialize(pedido)
		@pedido = Pedido.find(pedido)
	end

	def generate_remito()
		reporte = {}

		@pedido.each do |pedido|
			JSON.parse(pedido.items).map do |i|
				producto = Producto.find(i['producto_id']) rescue nil

				if producto.present?
					circulo_id = pedido.circulo_id

					grupo = I18n.t(producto.pack)

					unless reporte.has_key?(circulo_id)
						reporte[circulo_id] = {
								grupos: {}
						}
					end

					unless reporte[circulo_id][:grupos].has_key?(grupo)
						reporte[circulo_id][:grupos][grupo] = {
								productos: {}
						}
					end

					# If the product exist on the report sums, if it's new it assignes
					if reporte[circulo_id][:grupos][grupo][:productos].has_key?(i['producto_id'])
						reporte[circulo_id][:grupos][grupo][:productos][i['producto_id']][:qty] += i['cantidad']
					else
						reporte[circulo_id][:grupos][grupo][:productos][i['producto_id']] = {}
						reporte[circulo_id][:grupos][grupo][:productos][i['producto_id']][:name] = producto.nombre
						reporte[circulo_id][:grupos][grupo][:productos][i['producto_id']][:qty] = i['cantidad']
						reporte[circulo_id][:grupos][grupo][:productos][i['producto_id']][:faltante] = producto.faltante
						reporte[circulo_id][:grupos][grupo][:productos][i['producto_id']][:orden_remito] = producto.orden_remito || 0
					end

				end
			end
		end

		reporte.each do |circulo_id, repo|
			repo[:grupos].each do |grupo, productos|
				productos_array = productos[:productos].values
				productos[:productos] = productos_array.sort {|a,b| a[:orden_remito] <=> b[:orden_remito]}
			end
		end

		reporte
	end

end