class AddPrecioSuperToProductos < ActiveRecord::Migration[4.2]
  def change
    add_column :productos, :precio_super, :float
  end
end
