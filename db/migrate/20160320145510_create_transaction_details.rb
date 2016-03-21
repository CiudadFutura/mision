class CreateTransactionDetails < ActiveRecord::Migration
  def change
    create_table :transaction_details do |t|
      t.integer :transaction_id
      t.integer :producto_id
      t.float :price
      t.integer :quantity
      t.float :subtotal

      t.timestamps
    end
  end
end
