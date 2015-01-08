class CartsController < ApplicationController
  # Habilitar cuando se instale devise
  # before_action :authenticate_user!

  # before_action :set_carrito, only: [:show, :add, :remove]

  def show
  end

  def add
    @carrito.add(params[:producto_id], params[:cantidad])
    render json: @carrito.to_json, status: 200
  end

  def remove
    @carrito.remove(params[:producto_id])
    render json: @carrito.to_json, status: 200
  end

  def create_pedido
    pedido = Pedido.new
    pedido.populate!(@carrito, current_usuario)
    respond_to do |format|
      if pedido.save!
        @carrito.empty!
        format.html { redirect_to root_path, notice: 'Pedido enviado a al coordinador' }
      else
        format.html { render :show }
      end
    end
  end

  private

  # # Use callbacks to share common setup or constraints between actions.
  # def set_carrito
  #   @carrito = Cart.new(session)
  # end

  # Never trust parameters from the scary internet, only allow the white list through.
  def cart_params
    params.permit(:producto_id, :cantidad)
  end
end
