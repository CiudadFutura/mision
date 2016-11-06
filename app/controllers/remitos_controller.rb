class RemitosController < ApplicationController

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

	# remito/show
	def show
		pedido = Pedido.find(params[:id])
		@remito = Remito.new(pedido)
		respond_to do |format|
			format.html # show.html.erb
			format.xml  { render :xml => @remito }
			format.pdf { render :layout => false } # Add this line
		end
	end

	def get_by_cycle_circle
		@compra = Compra.find(params[:id])
		@reporte = Pedido.remitos(@compra.circulos.find(params[:circulo]).pedidos)

		render 'remitos'

	end

  def generate
    if current_usuario.admin?
      @productos = Producto.all
    end
	end


end
