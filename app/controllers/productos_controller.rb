class ProductosController < ApplicationController
  before_action :set_producto, only: [:show, :edit, :update, :destroy]

  # GET /productos
  # GET /productos.json
  def index
    @isD7 = false
    if params[:categoria_id] != 'Todas' && params[:categoria_id].present?
      if params[:subcategoria_id].present?
        @productos = Producto.joins(:categorias)
                         .where("categorias_productos.categoria_id = :sub_id AND categorias.parent_id = :id", id: params[:categoria_id], sub_id: params[:subcategoria_id])
      else
        @productos = Producto.joins(:categorias)
                         .where("categorias.id = :id OR categorias.parent_id = :id", id: params[:categoria_id])
      end
    else
      if params[:categoria_id] == 'Todas' || !Categoria.find_by_nombre('D7')
        @productos = Producto.all.order(:nombre)
      else
        @productos = Producto.joins(:categorias)
                         .where("categorias.nombre = :nombre", nombre: 'D7')

        @productos_nuevos = Producto.where("categorias.nombre <> ? AND created_at >= ?", "D7", Time.zone.now.beginning_of_month)
        

        @isD7 = true
      end
    end
    @productos = @productos.disponibles.order(:nombre) if current_usuario.nil? || !current_usuario.admin?

    if current_usuario && current_usuario.admin?
      @todos = Producto.all.order(:nombre)
      respond_to do |format|
        format.html
        format.csv { export_csv(@todos) }
        # format.csv { render csv: @todos.to_csv, filename: "#{Time.now.to_i}_productos" }
      end
    end
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

  def upload
    @message = Producto.import(params[:file])
    if @message[0][:success].present?
      redirect_to productos_url, :flash => { :notice => @message[0][:message] }
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

  protected

  def export_csv(todos)
    filename = "#{Time.now.to_i}_productos.csv"
    content = todos.to_csv
    send_data content,
              :type => 'text/csv; charset=utf-8; header=present',
              :disposition => "attachment",
              :filename => filename
  end
end
