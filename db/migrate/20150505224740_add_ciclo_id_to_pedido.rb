class AddCicloIdToPedido < ActiveRecord::Migration
  def change
    add_reference :pedidos, :compra, index: true
  end
end
