class CreateCanastas < ActiveRecord::Migration
  def change
    create_table :canastas do |t|
      t.integer :producto_id
      t.text :description
      t.integer :qty

      t.timestamps
    end
  end
end
