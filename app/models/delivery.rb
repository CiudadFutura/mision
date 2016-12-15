class Delivery < ActiveRecord::Base
  self.table_name = 'circulos_compras'

  belongs_to :compra
  belongs_to :circulo
  belongs_to :usuario
  has_many :delivery_statuses
  has_many :sectors, :through => :delivery_statuses

end
