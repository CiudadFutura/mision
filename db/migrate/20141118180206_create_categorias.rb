class CreateCategorias < ActiveRecord::Migration
  def change
    create_table :categorias do |t|
      t.string :nombre
      t.text :descripcion

      t.timestamps
    end
  end
end
