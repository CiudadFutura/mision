class CreateWarehousesCompras < ActiveRecord::Migration[5.0]
  def change
    create_table :warehouses_compras do |t|
      t.belongs_to :warehouse
      t.belongs_to :compra
    end
  end
end
