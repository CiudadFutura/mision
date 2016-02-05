class ReportsController < ApplicationController

  # GET /reports
  # GET /reports.json
  def index
    if current_usuario.admin?
      ciclo_id = nil
      @reporte = nil
      @ciclos = Compra.all.order('fecha_fin_compras DESC')
      if params[:ciclo_id].present? || Compra.ciclo_actual_completo.present?
        ciclo_id = params[:ciclo_id] || Compra.ciclo_actual_completo.id
        p ciclo_id
        p "-----------------------"
        pedidos = Pedido.where(compra_id: ciclo_id)
        @reporte = Reporte.pedidos_por_proveedor(pedidos)
      end
    end
  end

end
