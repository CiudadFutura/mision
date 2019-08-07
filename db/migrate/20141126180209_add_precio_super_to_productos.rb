class AddPrecioSuperToProductos < ActiveRecord::Migration[5.0]
  def change
    add_column :productos, :precio_super, :float
  end
end
