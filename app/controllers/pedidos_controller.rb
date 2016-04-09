class PedidosController < ApplicationController
  before_action :set_pedido, only: [:show, :edit]

  def index
    if current_usuario.admin?
      @ciclo_id = nil
      if(params[:ciclo_id])
        @ciclo_id = params[:ciclo_id]
        @pedidos = Pedido.where(compra_id: params[:ciclo_id])
        @pedidos = @pedidos.order(:updated_at)
      end
      @ciclos = Compra.all.order('fecha_fin_compras DESC')
      @suppliers = Supplier.all
      respond_to do |format|
        format.html
        format.csv { render csv: @pedidos.to_csv, filename: "#{Time.now.to_i}_pedidos" }
      end
    elsif current_usuario.coordinador? || current_usuario.usuario?
      @pedidos = Pedido.where(usuario_id: current_usuario.id)
    end
  end

  def show
    @transactions = Transaction.where(pedido_id: params[:id])
    if current_usuario.admin?
      @pedidos = Pedido.all
      respond_to do |format|
        format.html
        format.xls
      end
    elsif current_usuario.coordinador? || current_usuario.usuario?
      @pedidos = Pedido.where(usuario_id: current_usuario.id)
    end
  end

  def edit
    @pedido.save_in_session(session)
    @pedido.delete
    redirect_to productos_path
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pedido
      @pedido = Pedido.find(params[:id])
    end
end
