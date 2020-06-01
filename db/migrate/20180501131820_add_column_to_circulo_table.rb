class AddColumnToCirculoTable < ActiveRecord::Migration[4.2]
  def change
    add_column :circulos, :warehouse_id, :integer
  end
end
