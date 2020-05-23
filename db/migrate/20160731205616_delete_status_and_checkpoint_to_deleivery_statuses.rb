class DeleteStatusAndCheckpointToDeleiveryStatuses < ActiveRecord::Migration[4.2]
  def change
    remove_column :delivery_statuses, :delivery_date
    remove_column :delivery_statuses, :checkpoint
  end
end
