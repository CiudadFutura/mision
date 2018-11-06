class ReportsController < ApplicationController

  # GET /reports
  # GET /reports.json
  def index
    if current_usuario.admin?
      ciclo_id = nil
      @reporte = nil
      @ciclos = Compra.all.order('fecha_fin_compras DESC')
      if params[:ciclo_id].present? || @current_cycle_complete.present?
        ciclo_id = params[:ciclo_id] || @current_cycle_complete.id
        p ciclo_id
        p '-----------------------'
        pedidos = Pedido.where(compra_id: ciclo_id)
        @reporte = Reporte.pedidos_por_proveedor(pedidos)
      end
    end
  end

  def circles_list
    @ciclos = Compra.order(:fecha_inicio_compras).last(6)
    @circulos = Circulo.all

  end

end
