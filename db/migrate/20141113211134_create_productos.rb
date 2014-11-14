class CreateProductos < ActiveRecord::Migration
  def change
    create_table :productos do |t|
      t.float :precio
      t.string :nombre
      t.text :descripcion
      t.float :ahorro
      t.integer :cantidad_permitida

      t.timestamps
    end
  end
end
