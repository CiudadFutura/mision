class RemoveColumnToPedidosDetails < ActiveRecord::Migration[4.2]
  def change
    remove_column :pedidos_details, :warehouse
  end
end
