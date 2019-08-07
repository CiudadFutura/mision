class CreateCategoriasProductos < ActiveRecord::Migration[5.0]
  def change
    create_table :categorias_productos do |t|
      t.belongs_to :categoria
      t.belongs_to :producto
    end
  end
end
