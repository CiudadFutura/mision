class PedidosController < ApplicationController
  def index
    @pedidos = Pedido.all
  end
end
