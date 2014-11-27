class AddPrecioSuperToProductos < ActiveRecord::Migration
  def change
    add_column :productos, :precio_super, :float
  end
end
