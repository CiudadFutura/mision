class ChangeCodigoColumnToPedidosDetails < ActiveRecord::Migration[4.2]
  def change
		change_column :pedidos_details, :product_codigo, :string
  end
end
