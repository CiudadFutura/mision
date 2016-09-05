class DeleteStatusAndCheckpointToDeleiveryStatuses < ActiveRecord::Migration
  def change
    remove_column :delivery_statuses, :delivery_date
    remove_column :delivery_statuses, :checkpoint
  end
end
