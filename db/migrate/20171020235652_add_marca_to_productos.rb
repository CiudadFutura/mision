class AddMarcaToProductos < ActiveRecord::Migration[4.2]
  def change
    add_column :productos, :marca, :string
  end
end
