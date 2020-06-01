class CreateSuppliers < ActiveRecord::Migration[4.2]
  def change
    create_table :suppliers do |t|
      t.string :name
      t.string :address
      t.integer :nature, default: 0

      t.timestamps
    end
  end
end
