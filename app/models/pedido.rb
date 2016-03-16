require 'csv'

class Pedido < ActiveRecord::Base
  belongs_to :circulo
  belongs_to :usuario
  belongs_to :ciclo, class_name: "Compra", foreign_key: :compra_id

  validate :circulo, presence: true

  has_paper_trail


  def total
    total = 0.0
    JSON.parse(items).each { |item| total += item['total'] || 0 }
    total.to_f
  end

  def save_in_session(session)
    carrito = Cart.new(session)
    JSON.parse(items, symbolize_names: true).each do |item|
      carrito.add(item[:producto_id], item[:cantidad])
    end
  end

  def self.pedidos_ciclos
    pedidos_por_ciclos = Pedido.joins(:ciclo)
                  .select("compras.*, max(pedidos.created_at) as most_recent, count(pedidos.id) as orders_count")
                  .group('pedidos.compra_id')
    return pedidos_por_ciclos
  end

  def has_missing
    missing = false
    JSON.parse(self.items, symbolize_names: true).each do |item|
      producto = Producto.find(item[:producto_id])
      puts(producto.faltante)
      if producto.faltante?
        missing = true
        break
      else
        missing = false
      end
    end
    return missing
  end

  def self.to_csv
    CSV.generate(force_quotes: true) do |csv|
      csv << ['Pedido Nro', 'Ciclo Nro', 'Usuario Nro', 'Usuario', 'Circulo Nro', 'Codigo Prod.', 'Nombre Prod.', 'Cantidad']
      all.each do |pedido|
        JSON.parse(pedido.items, symbolize_names: true).each do |item|
          begin
            producto = Producto.find(item[:producto_id])
            csv << [
              pedido.id,
              pedido.ciclo.id,
              pedido.usuario.id,
              "#{pedido.usuario.apellido}, #{pedido.usuario.nombre}",
              pedido.circulo.id,
              producto.codigo,
              producto.nombre,
              item[:cantidad]
            ]
          rescue ActiveRecord::RecordNotFound
            csv << [
              pedido.id,
              pedido.ciclo.id,
              pedido.usuario.id,
              "#{pedido.usuario.apellido}, #{pedido.usuario.nombre}",
              pedido.circulo.id,
              item[:producto_id],
              'ERROR',
              item[:cantidad]
            ]
          end
        end
      end
    end
  end

  def self.remitos(pedidos)
    reporte = {}

    pedidos.each do |pedido|
      JSON.parse(pedido.items).map do |i|
        producto = Producto.find(i['producto_id'])
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
        end

      end
    end
    reporte
  end

end
