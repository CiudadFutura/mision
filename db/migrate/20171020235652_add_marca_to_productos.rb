class AddMarcaToProductos < ActiveRecord::Migration
  def change
    add_column :productos, :marca, :string
  end
end
