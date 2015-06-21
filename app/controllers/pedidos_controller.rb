class PedidosController < ApplicationController
  before_action :set_pedido, only: [:show, :edit]

  def index
    if current_usuario.admin?
      @pedidos = Pedido.all
    elsif current_usuario.coordinador? || current_usuario.usuario?
      @pedidos = Pedido.where(usuario_id: current_usuario.id)
    end
  end

  def show
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
