class AddCodigoToProductos < ActiveRecord::Migration
  def change
    add_column :productos, :codigo, :string
  end
end
