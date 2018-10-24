class Warehouse < ActiveRecord::Base
  has_many :warehouses_compras
  has_many :compras, :through => :warehouses_compras
  has_many :circulos

end
