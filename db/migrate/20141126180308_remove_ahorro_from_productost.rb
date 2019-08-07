class RemoveAhorroFromProductost < ActiveRecord::Migration[5.0]
  def change
    remove_column :productos, :ahorro
  end
end
