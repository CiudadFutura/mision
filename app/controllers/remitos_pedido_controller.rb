class RemitosPedidoController < ApplicationController

  def index
    if current_usuario.admin?
      @ciclos = Compra.all.order('fecha_fin_compras DESC')
      if params[:ciclo_id]
        if params[:circulo_id].present?
          pedidos = Pedido.where(compra_id: params[:ciclo_id],circulo_id: params[:circulo_id])
        else
          pedidos = Pedido.where(compra_id: params[:ciclo_id])
        end
        @reporte = Pedido.remitos(pedidos)
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
