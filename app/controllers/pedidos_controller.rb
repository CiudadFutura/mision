class PedidosController < ApplicationController
  before_action :set_pedido, only: [:show, :edit, :destroy]
	before_action :migrate, only: [:index]

  def index
    if current_usuario.admin?
      @ciclo_id = nil
      if(params[:ciclo_id])
        @ciclo_id = params[:ciclo_id]
        @pedidos = Pedido.where(compra_id: params[:ciclo_id]).order(:updated_at)
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
    transaction = Transaction.find_by_pedido_id(@pedido.id)
    JSON.parse(@pedido.items).map do |item|
			producto = Producto.find(item['producto_id'])
			if producto.stock.present?
				producto.oculto = false if producto.oculto?
				producto.stock += item['cantidad']
				producto.save
			end
		end
		delivery = Delivery.where(circulo_id: @pedido.circulo, usuarios_id: @pedido.usuario_id)
		if delivery.present?
			delivery.delete_all(circulo_id: @pedido.circulo, usuarios_id: @pedido.usuario_id)
		end
    @pedido.save_in_session(session)
    if transaction.present?
      transaction.pedido_id = nil
      transaction.save
		end
    @pedido.destroy
    redirect_to productos_path
	end


  # DELETE /categoria/1
  # DELETE /categoria/1.json
  def destroy
    @pedido.destroy
    respond_to do |format|
      format.html { redirect_to pedidos_url, notice: 'Pedido eliminado exitosamente.' }
      format.json { head :no_content }
    end
	end

	def migrate
		pedidos = Pedido.all
		pedidos.each do |pedido|
			#pedido.saving = pedido.ahorro
			total_amount = 0
			JSON.parse(pedido.items).map do |item|
				producto = Producto.find(item["producto_id"]) rescue nil
				if producto.present?
					supplier = Supplier.find(producto.supplier)
				end
				total_amount += item["total"].to_i
				if pedido.pedidos_details.blank?
					pedido_details = pedido.pedidos_details.build(
							supplier_id: supplier.present? ? supplier.id : 'Sin Proveedor ID',
							supplier_name: supplier.present? ? supplier.name : 'Sin Proveedor Nombre',
							product_id: item["producto_id"],
							product_codigo: producto.present? ? producto.codigo : 'Sin Código',
							product_name: producto.present? ? producto.nombre : 'Sin Nombre',
							product_qty: item["cantidad"].to_i,
							product_price: (item["total"] / item["cantidad"]).to_f,
							total_line: (item["total"]).to_f

					)
					pedido.total = total_amount
					pedido.total_products = pedido.cantidad
					pedido_details.save
					total_amount = 0
				end
			end
		end

	end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pedido
      @pedido = Pedido.find(params[:id])
    end
end
