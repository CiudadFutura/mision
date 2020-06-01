class CreatePedidosDetails < ActiveRecord::Migration[4.2]
  def change
    create_table :pedidos_details do |t|
			t.integer :pedido_id
			t.integer :invoice_id
			t.integer :warehouse
			t.integer :mai_id
			t.integer :supplier_id
			t.string :supplier_name
			t.integer :product_id
			t.integer :product_codigo
			t.string :product_name
			t.integer :product_qty
			t.float :product_price
			t.float :total_line

			t.timestamps
    end
  end
end
