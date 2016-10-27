class CreateCartsProducts < ActiveRecord::Migration
  def change
    create_table :carts_products do |t|
			t.integer :cart_id
			t.integer :producto_id
			t.integer :quantity


			t.timestamps
    end
  end
end
