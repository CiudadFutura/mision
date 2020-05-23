class AddCicloIdToPedido < ActiveRecord::Migration[4.2]
  def change
    add_reference :pedidos, :compra, index: true
  end
end
