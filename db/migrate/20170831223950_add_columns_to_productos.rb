class AddColumnsToProductos < ActiveRecord::Migration[4.2]
  def change
    add_column :productos, :costo, :text
    add_column :productos, :moneda, :text
    add_column :productos, :margen, :text
    add_column :productos, :alicuota, :text
  end
end
