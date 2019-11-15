class RemitosPedidoController < ApplicationController

  def index
    if current_usuario.admin?
      @ciclos = Compra.all.order('fecha_fin_compras').last(10)
      if params[:ciclo_id]
        if params[:circulo_id].present?
          pedidos = Pedido.where(compra_id: params[:ciclo_id],circulo_id: params[:circulo_id])
          pedidos2 = Pedido.remito_order(params[:ciclo_id], params[:circulo_id])

        else
          pedidos = Pedido.where(compra_id: params[:ciclo_id])
        end
        #@reporte = Pedido.remitos(pedidos)
        @remitos = Pedido.quotes(pedidos)
        @consumers = Pedido.consumers(@remitos)
      end
    end
    respond_to do |format|
      format.html
      format.pdf do
        pdf = ExportPdf.new(@remitos, @consumers)
        send_data pdf.render,
                  filename: "export.pdf",
                  type: 'application/pdf',
                  disposition: 'inline'
      end
    end
  end

	def get_by_cycle_circle
		@reporte = Pedido.remitos(Pedido.where(circulo_id: params[:circulo], compra_id: params[:id] ))

		render 'remitos'

	end

  def generate
    if current_usuario.admin?
      @productos = Producto.all
    end
	end


end
