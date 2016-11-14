class Categoria < ActiveRecord::Base
  has_and_belongs_to_many :productos
  has_many :subcategorias, class_name: "Categoria",
                           foreign_key: "parent_id"
 
  belongs_to :parent, class_name: "Categoria"

	TODAS = 'Todas'
end
