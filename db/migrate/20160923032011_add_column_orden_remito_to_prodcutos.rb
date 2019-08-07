class AddColumnOrdenRemitoToProdcutos < ActiveRecord::Migration[5.0]
  def change
    add_column :productos, :orden_remito, :integer
  end
end
