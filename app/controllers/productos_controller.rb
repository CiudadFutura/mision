class ProductosController < ApplicationController
  before_action :set_producto, only: [:show, :edit, :update, :destroy]

  # GET /productos
  # GET /productos.json
  def index
    if params[:categoria_id].present?
      if params[:subcategoria_id].present?
        @productos = Producto.joins(:categorias)
                         .where("categorias_productos.categoria_id = :sub_id AND categorias.parent_id = :id", id: params[:categoria_id], sub_id: params[:subcategoria_id])
      else
        @productos = Producto.joins(:categorias)
                         .where("categorias.id = :id OR categorias.parent_id = :id", id: params[:categoria_id])
      end
    else
      @productos = Producto.all.order(:nombre)
    end
    @productos = @productos.disponibles.order(:nombre) if current_usuario.nil? || !current_usuario.admin?
  end

  # GET /productos/1
  # GET /productos/1.json
  def show
    # todo: Se sigue usando???
    # @cart_action = @producto.cart_action(session)
  end

  # GET /productos/new
  def new
    @producto = Producto.new
  end

  # GET /productos/1/edit
  def edit
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
        format.html { redirect_to @producto, notice: 'Producto modificado exitosamente..' }
        format.json { render :show, status: :ok, location: @producto }
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_producto
      @producto = Producto.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def producto_params
      params.require(:producto).permit(:precio, :nombre, :codigo, :descripcion, 
                                       :precio_super, :oculto, :supplier_id,
                                       :cantidad_permitida, :imagen, categoria_ids: []
                                        )
    end
end
