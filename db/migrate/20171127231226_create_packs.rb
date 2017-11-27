class CreatePacks < ActiveRecord::Migration
  def change
    create_table :packs do |t|
      t.string :code
      t.string :name
      t.float :price
      t.float :price_super
      t.text :description
      t.integer :id_producto
      t.integer :id_supplier
      t.integer :amount_allowed
      t.string :picture
      t.string :brand
      t.boolean :active

      t.timestamps
    end
  end
end
