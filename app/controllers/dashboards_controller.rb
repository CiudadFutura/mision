class DashboardsController < ApplicationController

  def index
    @pedidosCiclos = Pedido::pedidos_ciclos
    @coordinadoresNuevos = Usuario::nuevos_coordinadores
    render 'home/home_admin'
  end

end
