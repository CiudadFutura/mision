class AddImagenToProductos < ActiveRecord::Migration[5.0]
  def change
    add_column :productos, :imagen, :string
  end
end
