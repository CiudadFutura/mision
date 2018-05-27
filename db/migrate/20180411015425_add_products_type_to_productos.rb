class AddProductsTypeToProductos < ActiveRecord::Migration
  def change
    add_column :productos, :product_type, :integer
  end
end
