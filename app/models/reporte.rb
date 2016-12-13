class Reporte
  def self.pedidos_por_proveedor(pedidos)
    reporte = {}

    pedidos.each do |pedido|
      JSON.parse(pedido.items).map do |i|
        product = Producto.find(i['producto_id']) rescue nil
        if product.present?
          supplier_id = product.supplier.id

          unless reporte.has_key?(supplier_id)
            reporte[supplier_id] = {
                name: product.supplier.name,
                supplier_id: supplier_id,
                products: {}
            }
          end

          # If the product exist on the report sums, if it's new it assignes
          if reporte[supplier_id][:products].has_key?(i['producto_id'])
            reporte[supplier_id][:products][i['producto_id']][:qty] += i['cantidad']
          else
            reporte[supplier_id][:products][i['producto_id']] = {}
            reporte[supplier_id][:products][i['producto_id']][:name] = product.nombre
            reporte[supplier_id][:products][i['producto_id']][:qty] = i['cantidad']
            reporte[supplier_id][:products][i['producto_id']][:codigo] = product.codigo
          end

        end


      end
    end
    reporte
  end
end