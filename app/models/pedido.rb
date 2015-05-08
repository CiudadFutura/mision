class Pedido < ActiveRecord::Base
  belongs_to :circulo
  belongs_to :usuario
  belongs_to :ciclo, class_name: "Compra", foreign_key: :compra_id

  validate :circulo, presence: true
end
