class DeleteStatusAndCheckpointToDeleiveryStatuses < ActiveRecord::Migration[5.0][5.0]
  def change
    remove_column :delivery_statuses, :delivery_date
    remove_column :delivery_statuses, :checkpoint
  end
end
