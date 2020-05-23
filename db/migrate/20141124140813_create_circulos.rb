class CreateCirculos < ActiveRecord::Migration[4.2]
  def change
    create_table :circulos do |t|
      t.integer :coordinador_id

      t.timestamps
    end
  end
end
