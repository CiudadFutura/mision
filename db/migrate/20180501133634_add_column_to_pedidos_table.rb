class AddColumnToPedidosTable < ActiveRecord::Migration[4.2]
  def change
    add_column :pedidos, :warehouse_id, :integer
  end
end
