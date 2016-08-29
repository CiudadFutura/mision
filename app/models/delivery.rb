class Delivery < ActiveRecord::Base
  self.table_name = 'circulos_compras'

  belongs_to :compra
  belongs_to :circulo
  has_many :delivery_statuses
  has_many :sectors, :through => :delivery_statuses

end
