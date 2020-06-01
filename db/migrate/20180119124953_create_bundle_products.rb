class CreateBundleProducts < ActiveRecord::Migration[4.2]
  def change
    create_table :bundle_products do |t|
      t.integer :producto_id
      t.integer :item_id
      t.text :description
      t.integer :qty

      t.timestamps
    end
  end
end
