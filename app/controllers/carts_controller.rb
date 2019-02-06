class CartsController < ApplicationController
  # Habilitar cuando se instale devise
  # before_action :authenticate_user!

  # before_action :set_carrito, only: [:show, :add, :remove]

  def show
    @category = Categoria.order("RAND()").limit(1)
    @missing = @carrito.check_item_stock
    if usuario_signed_in?
        @transactions = Transaction.where(["account_id = :id and pedido_id is null", {id: current_usuario.account.id }])
    end
  end

  def add
    @carrito.add(params[:producto_id], params[:cantidad])
    render json: @carrito.to_json, status: 200
=begin
    if current_usuario.coordinador? and !@carrito.producto?(296)
      @carrito.add(296, 1)
    end
=end
  end

  def remove
    @carrito.remove(params[:producto_id])
    render json: @carrito.to_json, status: 200
  end

  def create_pedido

    pedido = Pedido.new
    ciclo = @current_cycle
    pedido.items = @carrito.items.map { |_k,item| item.purchase_data }.to_json

		if current_usuario.present?
      if current_usuario.circulo.present?
        pedido.circulo_id = current_usuario.circulo_id
        circulo = Circulo.find(pedido.circulo_id) if current_usuario
      end

      usuario_id = current_usuario.id

      transactions = Transaction.where(["account_id = :id and pedido_id is null", {id: current_usuario.account.id }])
    elsif params[:usuarios][:guest]
      usuario = Usuario.find_by_email(params[:usuarios][:email])
      if usuario.blank?
        new_usuario = Usuario.new(
          email: params[:usuarios][:email],
          nombre: params[:usuarios][:nombre],
          apellido: params[:usuarios][:apellido],
          password: BCrypt::Password.create(('ewrwerwerwerwer2222')),
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
    if current_usuario.blank?
      usuario_id = usuario.id
    end
    pedido.usuario_id = usuario_id
		pedido.compra_id = ciclo.id
		missing = @carrito.check_item_stock
		pedido.total_discount = @carrito.total_discount
		pedido.total = @carrito.total
		pedido.saving = @carrito.ahorro
		pedido.total_products = @carrito.cantidad
    pedido.warehouse_id = circulo.warehouse_id
		pedido.active = true
    if params.has_key?(:usuarios)
      warehouse = params[:usuarios][:warehouse]
    elsif params.has_key?(:pedidos)
      warehouse = params[:pedidos][:warehouse]
    else
      warehouse = nil
    end
    respond_to do |format|
			if missing.blank?
				if pedido.save!
					@carrito.items.map do |key, item|
						next if item.blank?
						producto = Producto.find(item.producto.id)
						pedido_details = pedido.pedidos_details.build(
																											 supplier_id: Supplier.find(producto.supplier).id,
																											 supplier_name: Supplier.find(producto.supplier).name,
																											 product_id: producto.id,
																											 product_codigo: producto.codigo,
																											 product_name: producto.nombre,
																											 product_qty: item.cantidad.to_i,
																											 product_price: producto.precio,
																											 total_line: (item.cantidad.to_i * producto.precio).to_f

						)
						pedido_details.save
					end

					if transactions.present?
						transactions.each do |transaction|
							transaction.pedido_id = pedido.id
							transaction.save
						end
					end
					if circulo.present?
						delivery = circulo.deliveries.where(compra_id: ciclo.id)
					else
						delivery = Delivery.new(
																	 usuarios_id: usuario_id,
																	 compra_id: ciclo.id,
																	 delivery_time: ciclo.fecha_entrega_compras,
																	 warehouses_id: warehouse
						).save
					end
					if ciclo.tipo == 'circles'
						if delivery.blank?
							Sector.all.each do |sector|
								if sector.id == Sector::CONSUMERS
									status_id = Status::SCHEDULED
								else
									status_id = nil
								end
								delivery_status = DeliveryStatus.create(
										delivery_id: delivery.take.id,
										sector_id: sector.id,
										status_id: status_id
								)
								delivery.take.delivery_time = ciclo.fecha_entrega_compras
								delivery.take.save
								delivery_status.save
							end
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
    if current_usuario.present?
      circulo = Circulo.find(current_usuario.circulo_id) if current_usuario.circulo_id.present?
      @next_cycle = circulo.next_delivery.offset(1).last if circulo.present?
    end
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
