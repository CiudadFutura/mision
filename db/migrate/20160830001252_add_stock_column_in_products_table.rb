class AddStockColumnInProductsTable < ActiveRecord::Migration
  def change
    add_column :productos, :stock, :integer
  end
end
