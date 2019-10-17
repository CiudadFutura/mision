class ChangeRemitoOrderTypeToProducto < ActiveRecord::Migration[5.2]
  def up
    change_column :productos, :orden_remito, :string
  end

  def down
    change_column :productos, :orden_remito, :integer
  end
end
