class EditOrderField < ActiveRecord::Migration[4.2]
  def change
    rename_column :productos, :order, :orden
  end
end
