class AddFaltantePacksColumnsToProducto < ActiveRecord::Migration[4.2]
  def change
    add_column :productos, :faltante, :boolean
    add_column :productos, :pack, :integer, default: 0
  end
end
