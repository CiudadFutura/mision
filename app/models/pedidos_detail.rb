class PedidosDetail < ActiveRecord::Base
	belongs_to :pedido
  has_many :productos

end