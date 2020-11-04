class Categoria < ActiveRecord::Base
  has_and_belongs_to_many :productos
  has_many :subcategorias, class_name: "Categoria",
                           foreign_key: "parent_id"
 
  belongs_to :parent, class_name: "Categoria"
  has_and_belongs_to_many :productos

	TODAS = 'Todas'

  def self.build_menu
    menu = []
    Categoria.where(parent_id: 0).each do |cat_parent|
      cat = {
          id: cat_parent.id,
          nombre: cat_parent.nombre,
          subcategorias: []
      }
      cat_parent.subcategorias.each do |subcategoria|
        cat[:subcategorias] << {
            id: subcategoria.id,
            nombre: subcategoria.nombre,
            parent_id: subcategoria.parent_id
        }
      end
      menu << cat
    end
    menu
  end
end
