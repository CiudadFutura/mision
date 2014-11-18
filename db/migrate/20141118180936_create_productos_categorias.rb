class CreateProductosCategorias < ActiveRecord::Migration
  def change
    create_table :productos_categorias do |t|
      t.belongs_to :producto
      t.belongs_to :categoria
    end
  end
end
