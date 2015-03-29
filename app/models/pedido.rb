class Pedido < ActiveRecord::Base
  belongs_to :circulo
  belongs_to :usuario

  def populate!(carrito, current_user)
  	items = carrito.items.map(&:to_json).to_s
    usuario_id = current_usuario.id
    circulo_id = current_usuario.circulo_id
  end
end
