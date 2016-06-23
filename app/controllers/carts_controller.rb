class CartsController < ApplicationController
  # Habilitar cuando se instale devise
  # before_action :authenticate_user!

  # before_action :set_carrito, only: [:show, :add, :remove]

  def show
    @ciclo_actual = Compra::ciclo_actual
    if usuario_signed_in?
        @transactions = Transaction.where(["account_id = :id and pedido_id is null", {id: current_usuario.account.id }])
    end
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
    transactions = Transaction.where(["account_id = :id and pedido_id is null", {id: current_usuario.account.id }])
    pedido = Pedido.new
    ciclo_id = Compra.ciclo_actual.id
    pedido.items = @carrito.items.map { |_k,item| item.purchase_data }.to_json
    pedido.usuario_id = current_usuario.id
    pedido.circulo_id = current_usuario.circulo_id
    pedido.compra_id = ciclo_id
    respond_to do |format|
      if pedido.save!
        if transactions.present?
          transactions.each do |transaction|
            transaction.pedido_id = pedido.id
            transaction.save
          end
        end
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
