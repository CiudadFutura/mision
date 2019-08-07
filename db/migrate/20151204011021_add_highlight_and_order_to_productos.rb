class AddHighlightAndOrderToProductos < ActiveRecord::Migration[5.0]
  def change
    add_column :productos, :order, :integer, default: 0
    add_column :productos, :highlight, :boolean, default: false
  end
end
