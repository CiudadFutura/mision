class Pedido < ActiveRecord::Base
  belongs_to :circulo
  belongs_to :usuario
end
