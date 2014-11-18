class Categoria < ActiveRecord::Base
  has_many :productos
end
