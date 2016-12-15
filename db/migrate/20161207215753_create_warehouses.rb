class CreateWarehouses < ActiveRecord::Migration
  def change
    create_table :warehouses do |t|
			t.string :name
			t.text :description
			t.string :address
			t.string :telephone
			t.string :working_hours
			t.string :attendant

			t.timestamps
    end
  end
end
