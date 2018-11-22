class Warehouse < ActiveRecord::Base
  has_many :warehouses_compras
  has_many :compras, :through => :warehouses_compras
  has_many :circulos
  has_and_belongs_to_many :productos

end
