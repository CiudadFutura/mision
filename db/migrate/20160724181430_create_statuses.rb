class CreateStatuses < ActiveRecord::Migration[4.2]
  def change
    create_table :statuses do |t|
      t.string :name # 0 = Scheduled, 1 = On Hold, 2 = Assigned, 3 = Delivered, 4 = Completed

      t.timestamps
    end
  end
end
