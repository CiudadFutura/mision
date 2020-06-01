class AddCodigoToProductos < ActiveRecord::Migration[4.2]
  def change
    add_column :productos, :codigo, :string
  end
end
