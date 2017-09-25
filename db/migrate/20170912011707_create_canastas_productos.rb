class CreateCanastasProductos < ActiveRecord::Migration
  def change
    create_table :canastas_productos do |t|
      t.belongs_to :producto

      t.timestamps
    end
  end
end
