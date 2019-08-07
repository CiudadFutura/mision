class ChangeCodigoColumnToPedidosDetails < ActiveRecord::Migration[5.0]
  def change
		change_column :pedidos_details, :product_codigo, :string
  end
end
