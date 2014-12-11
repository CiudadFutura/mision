class CreateCirculos < ActiveRecord::Migration
  def change
    create_table :circulos do |t|
      t.integer :coordinador_id

      t.timestamps
    end
  end
end
