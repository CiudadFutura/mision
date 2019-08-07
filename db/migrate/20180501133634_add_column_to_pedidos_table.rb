class AddColumnToPedidosTable < ActiveRecord::Migration[5.0]
  def change
    add_column :pedidos, :warehouse_id, :integer
  end
end
