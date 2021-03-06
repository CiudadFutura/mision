class PedidosController < ApplicationController
  before_action :set_pedido, only: [:show, :edit, :destroy]
  protect_from_forgery with: :exception
  authorize_resource

  def index
    if current_usuario.admin?
      if(params[:ciclo_id])
        @ciclo_id = params[:ciclo_id]
        @exportCSV = Pedido.where(compra_id: params[:ciclo_id]).order(:updated_at)
        @pedidos = @exportCSV.paginate(:page => params[:page], :per_page => 50)

      end
      if (params[:text_search])
        @pedidos = Pedido.search(params[:text_search]).paginate(:page => params[:page], :per_page => 50)
      end
      @ciclos = Compra.all.order('fecha_fin_compras DESC')
      @suppliers = Supplier.all
      respond_to do |format|
        format.html { render 'pedidos/index_admin' }
        format.csv { send_data @exportCSV.to_csv, filename: "#{Time.now.to_i}_pedidos.csv"}
        #format.csv { render csv: @exportCSV, filename: "#{Time.now.to_i}_pedidos"}
      end
    elsif current_usuario.coordinador? || current_usuario.usuario?
      @pedidos = Pedido.where(usuario_id: current_usuario.id)
                   .paginate(:page => params[:page], :per_page => 10).order('id DESC')
    end
  end

  def show
    @category = Categoria.order("RAND()").limit(1)
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
    category = Categoria.order("RAND()").limit(1)
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
			delivery.delete_all()
		end
    @pedido.save_in_session(session)
    if transaction.present?
      transaction.pedido_id = nil
      transaction.save
		end
    @pedido.destroy
    redirect_to productos_path(categoria_id: category.first.id)
  end


  def download_pdf
    pedido = Pedido.find(params[:pedido_id])
    if pedido.usuario_id == current_usuario.id
      send_file(
        "#{Rails.root}/public/facturas/FAC_#{pedido.id}.pdf",
        type: "application/pdf"
      )
    else
      message = { alert: "La factura no pertenece a ese pedido" }
      redirect_to pedidos_url(), message
    end
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


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pedido
      @pedido = Pedido.find(params[:id])
    end
end
