class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
			t.integer :mai_id
			t.integer :usuario_id
			t.boolean :active

			t.timestamps
    end
  end
end
