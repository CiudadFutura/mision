class CartsController < ApplicationController
  # Habilitar cuando se instale devise
  # before_action :authenticate_user!

  # before_action :set_carrito, only: [:show, :add, :remove]

  def show
    @ciclos_actuales = Compra::ciclos_actuales
		if current_usuario
			@ciclo_actual = Compra::get_ciclo_actual(@ciclos_actuales, current_usuario.id).last
			@ciclo_actual_include = @ciclo_actual.deliveries.where(circulo_id: current_usuario.circulo.id).last
		else
			@ciclo_actual = @ciclos_actuales.where(tipo:1).last
		end
    @missing = @carrito.check_item_stock
    if usuario_signed_in? && !current_usuario.admin?
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
		@ciclos_actuales = Compra::ciclos_actuales
		if current_usuario
			@ciclo_actual = Compra::get_ciclo_actual(@ciclos_actuales, current_usuario.id).last
			@ciclo_actual_include = @ciclo_actual.deliveries.where(circulo_id: current_usuario.circulo.id).last
			transactions = Transaction.where(["account_id = :id and pedido_id is null", {id: current_usuario.account.id }])
		else
			@ciclo_actual = Compra.find(params[:usuarios][:ciclo_actual])
			usuario = Usuario.find_by_email(params[:usuarios][:email])
			if usuario.blank?
				new_usuario = Usuario.new(
						email: params[:usuarios][:email],
						nombre: params[:usuarios][:nombre],
						apellido: params[:usuarios][:apellido],
						password: ::BCrypt::Password.create(params[:usuarios][:password]).to_s,
						calle: params[:usuarios][:calle],
						ciudad: 'Rosario',
						pais: 'Argentina',
						cel1: params[:usuarios][:cel1],
						dni: params[:usuarios][:dni]
				)
				if new_usuario.save!
					usuario = new_usuario
				end
			end
		end
    pedido = Pedido.new
    ciclo_id = @ciclo_actual.id
    pedido.items = @carrito.items.map { |_k,item| item.purchase_data }.to_json
    pedido.usuario_id = current_usuario.present? ? current_usuario.id : usuario.id
    pedido.circulo_id = current_usuario.present? ? current_usuario.circulo.id : ''
		if current_usuario
			circulo = Circulo.find(pedido.circulo_id)
		end
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
					if circulo.present?
						delivery = circulo.deliveries.find_by(compra_id: ciclo_id).take
					else
						delivery = Delivery.new(
																	 usuarios_id: usuario.id,
																	 compra_id: ciclo_id,
																	 delivery_time: @ciclo_actual.fecha_entrega_compras,
																	 warehouses_id: params[:usuarios][:warehouse]
						).save
					end
					if delivery.blank?
						Sector.all.each do |sector|
							if sector.id == Sector::CONSUMERS
								status_id = Status::SCHEDULED
							else
								status_id = nil
							end
							delivery_status = DeliveryStatus.create(
									delivery_id: delivery.id,
									sector_id: sector.id,
									status_id: status_id
							)
							delivery.delivery_time = @ciclo_actual.fecha_entrega_compras
							delivery.save
							delivery_status.save
						end
					end
					@carrito.discount_stock
					@carrito.empty!
					format.html { redirect_to success_path(pedido.id) }
				else
					format.html { render :show }
				end
			else
				flash[:error] = missing
				format.html { redirect_to carts_show_path }
			end
    end
	end

	def success
		@pedido = Pedido.find(params[:id])
		render 'carts/success'
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
