class AddHighlightAndOrderToProductos < ActiveRecord::Migration
  def change
    add_column :productos, :order, :integer, default: 0
    add_column :productos, :highlight, :boolean, default: false
  end
end
