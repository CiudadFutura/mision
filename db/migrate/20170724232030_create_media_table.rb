class CreateMediaTable < ActiveRecord::Migration[5.0]
  def change
    create_table :media do |t|
      t.integer :owner_id
      t.string :file
      t.string :resource_type
      t.boolean :status

      t.timestamps
    end
  end
end
