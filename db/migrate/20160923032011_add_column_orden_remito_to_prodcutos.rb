class AddColumnOrdenRemitoToProdcutos < ActiveRecord::Migration
  def change
    add_column :productos, :orden_remito, :integer
  end
end
