class AddCicloIdToPedido < ActiveRecord::Migration[5.0]
  def change
    add_reference :pedidos, :compra, index: true
  end
end
