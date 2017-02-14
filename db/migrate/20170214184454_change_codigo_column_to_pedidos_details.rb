class ChangeCodigoColumnToPedidosDetails < ActiveRecord::Migration
  def change
		change_column :pedidos_details, :product_codigo, :string
  end
end
