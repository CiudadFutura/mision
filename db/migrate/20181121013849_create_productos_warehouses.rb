class CreateProductosWarehouses < ActiveRecord::Migration[4.2]
  def change
    create_table :productos_warehouses do |t|
      t.integer :producto_id
      t.belongs_to :warehouse
    end
  end
end
