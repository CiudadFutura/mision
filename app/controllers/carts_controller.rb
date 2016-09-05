class CartsController < ApplicationController
  # Habilitar cuando se instale devise
  # before_action :authenticate_user!

  # before_action :set_carrito, only: [:show, :add, :remove]

  def show
    @ciclo_actual = Compra::ciclo_actual
    @missing = @carrito.check_item_stock
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
    circulo = Circulo.find(pedido.circulo_id)
    pedido.compra_id = ciclo_id
    missing = @carrito.check_item_stock
    respond_to do |format|
			if missing.blank?
				if pedido.save!
					if transactions.present?
						transactions.each do |transaction|
							transaction.pedido_id = pedido.id
							transaction.save
						end
					end
					if circulo.has_delivery_time?(ciclo_id)
						Sector.all.each do |sector|
							if sector.id == 6
								status_id = 1
							else
								status_id = nil
							end
							delivery = circulo.deliveries.where('compra_id = ?', ciclo_id)
							delivery_status = DeliveryStatus.create(
									delivery_id: delivery.first.id,
									sector_id: sector.id,
									status_id: status_id
							)
							delivery.first.delivery_time = Compra.ciclo_actual.fecha_entrega_compras
							delivery.first.save
							delivery_status.save
						end
					@carrito.discount_stock
					@carrito.empty!
					format.html { redirect_to root_path, notice: 'Pedido enviado a al coordinador' }
				else
					format.html { render :show }
				end
			else
				flash[:error] = missing
				format.html { redirect_to carts_show_path }
    end
  end

  private

  # # Use callbacks to share common setup or constraints between actions.
  # def set_carrito
  #   @carrito = Cart.new(session)
  # end

  # Never trust parameters from the scary internet, only allow the white list through.
  def cart_params
    params.permit(:producto_id, :cantidad, :stock)
  end
end
