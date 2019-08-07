class RemoveColumnToPedidosDetails < ActiveRecord::Migration[5.0]
  def change
    remove_column :pedidos_details, :warehouse
  end
end
