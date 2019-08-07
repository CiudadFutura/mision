class CreateCirculos < ActiveRecord::Migration[5.0]
  def change
    create_table :circulos do |t|
      t.integer :coordinador_id

      t.timestamps
    end
  end
end
