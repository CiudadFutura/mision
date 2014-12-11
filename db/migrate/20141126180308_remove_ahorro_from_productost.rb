class RemoveAhorroFromProductost < ActiveRecord::Migration
  def change
    remove_column :productos, :ahorro
  end
end
