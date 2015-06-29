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

  def self.to_csv
    CSV.generate do |csv|
      csv << ['Pedido Nro', 'Ciclo Nro', 'Usuario Nro', 'Usuario', 'Circulo Nro', 'Codigo Prod.', 'Nombre Prod.', 'Cantidad']
      all.each do |pedido|
        JSON.parse(pedido.items, symbolize_names: true).each do |item|
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
        end
      end
    end
  end

end
