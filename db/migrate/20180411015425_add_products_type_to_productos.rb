class AddProductsTypeToProductos < ActiveRecord::Migration[4.2]
  def change
    add_column :productos, :product_type, :integer
  end
end
