class EditOrderField < ActiveRecord::Migration[5.0]
  def change
    rename_column :productos, :order, :orden
  end
end
