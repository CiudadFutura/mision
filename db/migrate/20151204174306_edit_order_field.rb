class EditOrderField < ActiveRecord::Migration
  def change
    rename_column :productos, :order, :orden
  end
end
