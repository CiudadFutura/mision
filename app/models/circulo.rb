class Circulo < ActiveRecord::Base
  belongs_to :coordinador
  has_many :pedidos
  has_many :usuarios
end
