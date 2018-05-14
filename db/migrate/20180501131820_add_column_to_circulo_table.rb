class AddColumnToCirculoTable < ActiveRecord::Migration
  def change
    add_column :circulos, :warehouse_id, :integer
  end
end
