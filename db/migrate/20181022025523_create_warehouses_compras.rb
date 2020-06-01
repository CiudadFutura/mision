class CreateWarehousesCompras < ActiveRecord::Migration[4.2]
  def change
    create_table :warehouses_compras do |t|
      t.belongs_to :warehouse
      t.belongs_to :compra
    end
  end
end
