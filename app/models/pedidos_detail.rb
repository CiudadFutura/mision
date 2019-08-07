class PedidosDetail < ActiveRecord::Base
	belongs_to :pedido
	
	def self.most_purchased
		PedidosDetail.group("product_id, product_name").order("quantity_sum desc").limit(10).pluck("product_name, sum(product_qty) as quantity_sum")
	end
	
end