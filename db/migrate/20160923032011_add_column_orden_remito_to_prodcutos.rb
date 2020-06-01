class AddColumnOrdenRemitoToProdcutos < ActiveRecord::Migration[4.2]
  def change
    add_column :productos, :orden_remito, :integer
  end
end
