class RemoveColumnToPedidosDetails < ActiveRecord::Migration
  def change
    remove_column :pedidos_details, :warehouse
  end
end
