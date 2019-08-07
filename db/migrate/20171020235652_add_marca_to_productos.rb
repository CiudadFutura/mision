class AddMarcaToProductos < ActiveRecord::Migration[5.0]
  def change
    add_column :productos, :marca, :string
  end
end
