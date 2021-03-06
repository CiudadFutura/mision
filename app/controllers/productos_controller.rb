class ProductosController < ApplicationController
  before_action :set_producto, only: [:show, :edit, :update, :destroy]
  autocomplete :producto, :nombre, :extra_data =>[:cantidad_permitida, :precio, :precio_super, :descripcion]

  # GET /productos
  # GET /productos.json
  def index
    if params['view_type'] == 'admin'
      session[:view_type] = 'admin'
    end
    if params['view_type'] == 'user'
      session.delete(:view_type)
    end
    if params['view_prod'] == 'ocultos'
      session[:view_prod] = 'ocultos'
    end
    if params['view_prod'] == 'visibles'
      session[:view_prod] = 'visibles'
    end
    if params['view_prod'] == 'wholesale'
      session[:view_prod] = 'wholesale'
    end
    if params['view_prod'] == 'todos'
      session.delete(:view_prod)
    end

    @view_type = session[:view_type]
    @view_prod = session[:view_prod]

    @todos = Producto.all
    if params[:categoria_id].blank?
      @productos = @todos.order(:orden, :nombre)
    else
		  @productos = @todos.order(:orden, :nombre).paginate(:page => params[:page], :per_page => 50)
    end
    @productos = @productos.stock if current_usuario.nil? || current_usuario.present? && !current_usuario.admin?
    @productos = @productos.disponibles.order(:orden, :nombre) if current_usuario.nil? || !current_usuario.admin?
    @productos = @productos.destacados if params[:featured].present?
    @productos = @productos.categoria(params[:categoria_id]) if params[:categoria_id]
    @productos = @productos.subcategoria(params[:categoria_id], params[:subcategoria_id]) if params[:subcategoria_id].present?
    @productos = @productos.disponibles if session['view_prod'] == 'visibles'
    @productos = @productos.ocultos if session['view_prod'] == 'ocultos'
    @productos = @productos.wholesaleProducts if session['view_prod'] == 'wholesale'
    @productos = @productos.supplier(params[:supplier_id]) if params[:supplier_id]
    @productos = @productos.not_selected(@current_warehouses_ids) if @current_warehouses_ids.present? and current_usuario.present?
    @impulsarProducts = Producto.wholesaleProducts if current_usuario.present? && current_usuario.productor? && !current_usuario.admin?
    @impulsarProducts = @impulsarProducts.stock if @impulsarProducts.present?
    @exclusives = Producto.warehouse_exclusive(@current_user_warehouse) if @current_user_warehouse.present? and current_usuario.present?
    @freesale = Producto.freesale

    if current_usuario && current_usuario.admin?
      if params[:text_search].present?
        @productos = @productos.search(params[:text_search]).paginate(:page => params[:page], :per_page => 50)
      else
        @productos = @productos.paginate(:page => params[:page], :per_page => 50)
      end
      respond_to do |format|
        format.html { render 'productos/index_admin'}
        format.csv { send_data @todos.to_csv,type: 'text/csv; charset=UTF-8; header=present', filename: "#{Time.now.to_i}_productos.csv"}
        #format.csv { render csv: @todos.to_csv, type: 'text/csv; charset=UTF-8; header=present', filename: "#{Time.now.to_i}_productos" }
      end
    end
  end

  # GET /productos/1
  # GET /productos/1.json
  def show
    cat = @producto.categorias.first.id
    @related_products = @producto.get_related_products(cat)

  end

  # GET /productos/new
  def new
    @producto = Producto.new
  end

  # GET /productos/1/edit
  def edit
		session[:return_to] ||= request.referer
  end

  # POST /productos
  # POST /productos.json
  def create
    @producto = Producto.new(producto_params)
    respond_to do |format|
      if @producto.save
        format.html { redirect_to @producto, notice: 'Producto creado exitosamente.' }
        format.json { render :show, status: :created, location: @producto }
      else
        format.html { render :new }
        format.json { render json: @producto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /productos/1
  # PATCH/PUT /productos/1.json
  def update
    respond_to do |format|
      if @producto.update(producto_params)
        format.html { redirect_to session.delete(:return_to), notice: 'Producto modificado exitosamente..' }
				format.js {}
        format.json { render json: @producto, status: :ok, location: @producto }
      else
        format.html { render :edit }
        format.json { render json: @producto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /productos/1
  # DELETE /productos/1.json
  def destroy
    @producto.destroy
    respond_to do |format|
      format.html { redirect_to productos_url, notice: 'Producto eliminado exitosamente.' }
      format.json { head :no_content }
    end
  end

  def edit_multiple
    @productos = Producto.find(params[:producto_ids])
    @productos.each do |producto|
      producto.update_attributes(:faltante => true)
    end
    flash[:notice] = "Updated productos!"
    redirect_to remitos_pedido_index_path
	end

  def upload
    @message = Producto.import(params[:file])
    if @message[0][:success].present?
      redirect_to productos_url, :flash => { :notice => @message[0][:message] }
    end
  end

  def bundle_item
    @items= Producto.find(params[:id])
    render 'productos/bundle_item.json'
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_producto

      @producto = Producto.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def producto_params
      params.require(:producto).permit(:precio, :nombre, :codigo, :descripcion, :orden,
                                       :precio_super, :highlight, :oculto, :marca, :supplier_id,
                                       :pack, :faltante,:cantidad_permitida, :imagen, :stock,
                                       :orden_remito, :view_type, :product_type,
																			 :sale_type, :wholesale,
                                       bundle_products_attributes: [:id, :item_id, :qty, :description],
                                       categoria_ids: [], warehouse_ids: [],)
    end
end
