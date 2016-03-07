class AddFaltantePacksColumnsToProducto < ActiveRecord::Migration
  def change
    add_column :productos, :faltante, :boolean
    add_column :productos, :pack, :integer, default: 0
  end
end
