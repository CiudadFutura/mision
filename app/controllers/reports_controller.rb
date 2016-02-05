class ReportsController < ApplicationController

  # GET /reports
  # GET /reports.json
  def index
    if current_usuario.admin?
        ciclo_id = params[:ciclo_id] || Compra.ciclo_actual.id
        p ciclo_id
        p "-----------------------"
        pedidos = Pedido.where(compra_id: ciclo_id)
        @reporte = Reporte.pedidos_por_proveedor(pedidos)
    end
  end

end