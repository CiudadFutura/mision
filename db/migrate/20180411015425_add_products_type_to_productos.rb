class AddProductsTypeToProductos < ActiveRecord::Migration[5.0]
  def change
    add_column :productos, :product_type, :integer
  end
end
