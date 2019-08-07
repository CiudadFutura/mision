class AddColumnToCirculoTable < ActiveRecord::Migration[5.0]
  def change
    add_column :circulos, :warehouse_id, :integer
  end
end
