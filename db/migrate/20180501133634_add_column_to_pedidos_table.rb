class AddColumnToPedidosTable < ActiveRecord::Migration
  def change
    add_column :pedidos, :warehouse_id, :integer
  end
end
