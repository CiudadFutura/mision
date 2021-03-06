class CreateTransactions < ActiveRecord::Migration[4.2]
  def change
    create_table :transactions do |t|
      t.integer :account_id
      t.integer :pedido_id
      t.integer :transaction_type
      t.float :amount
      t.text :description

      t.timestamps
    end
  end
end
