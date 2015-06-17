class PedidosController < ApplicationController
  def index
    if current_usuario.admin?
      @pedidos = Pedido.all
    elsif current_usuario.coordinador? || current_usuario.usuario?
      @pedidos = Pedido.where(usuario_id: current_usuario.id)
    end
  end
end
