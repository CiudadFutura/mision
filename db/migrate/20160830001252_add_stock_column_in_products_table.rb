class AddStockColumnInProductsTable < ActiveRecord::Migration[4.2]
  def change
    add_column :productos, :stock, :integer
  end
end
