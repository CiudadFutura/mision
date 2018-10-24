class WarehousesCompra < ActiveRecord::Base
  belongs_to :compra
  belongs_to :warehouse

end