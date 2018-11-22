class CreateProductosWarehouses < ActiveRecord::Migration
  def change
    create_table :productos_warehouses do |t|
      t.integer :producto_id
      t.belongs_to :warehouse
    end
  end
end
