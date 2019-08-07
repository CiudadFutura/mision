class AddStockColumnInProductsTable < ActiveRecord::Migration[5.0]
  def change
    add_column :productos, :stock, :integer
  end
end
