class CreateWarehousesCompras < ActiveRecord::Migration
  def change
    create_table :warehouses_compras do |t|
      t.belongs_to :warehouse
      t.belongs_to :compra
    end
  end
end
