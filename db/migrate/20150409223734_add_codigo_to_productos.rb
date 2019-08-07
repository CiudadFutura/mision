class AddCodigoToProductos < ActiveRecord::Migration[5.0]
  def change
    add_column :productos, :codigo, :string
  end
end
