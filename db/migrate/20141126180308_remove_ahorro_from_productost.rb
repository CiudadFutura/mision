class RemoveAhorroFromProductost < ActiveRecord::Migration[4.2]
  def change
    remove_column :productos, :ahorro
  end
end
