class PacksController < ApplicationController
  before_action :set_pack, only: [:show, :edit, :update, :destroy]

  # GET /packs
  # GET /packs.json
  def index

		@packs = Pack.all.order(:orden, :name)

    if current_usuario && current_usuario.admin?
      respond_to do |format|
        format.html
        format.csv { render csv: @todos.to_csv, type: 'text/csv; charset=UTF-8; header=present', filename: "#{Time.now.to_i}_packs" }
      end
    end
  end

  # GET /packs/1
  # GET /packs/1.json
  def show
    # todo: Se sigue usando???
    # @cart_action = @pack.cart_action(session)
  end

  # GET /packs/new
  def new
    @pack = Pack.new
  end

  # GET /packs/1/edit
  def edit
		session[:return_to] ||= request.referer
  end

  # POST /packs
  # POST /packs.json
  def create
    @pack = Pack.new(pack_params)
    respond_to do |format|
      if @pack.save
        format.html { redirect_to @pack, notice: 'Canasta creada exitosamente.' }
        format.json { render :show, status: :created, location: @pack }
      else
        format.html { render :new }
        format.json { render json: @pack.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /packs/1
  # PATCH/PUT /packs/1.json
  def update
    respond_to do |format|
      if @pack.update(pack_params)
        format.html { redirect_to session.delete(:return_to), notice: 'Canasta modificada exitosamente..' }
				format.js {}
        format.json { render json: @pack, status: :ok, location: @pack }
      else
        format.html { render :edit }
        format.json { render json: @pack.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /packs/1
  # DELETE /packs/1.json
  def destroy
    @pack.destroy
    respond_to do |format|
      format.html { redirect_to packs_url, notice: 'Canasta eliminada exitosamente.' }
      format.json { head :no_content }
    end
  end

  def edit_multiple
    @packs = Pack.find(params[:pack_ids])
    @packs.each do |pack|
      pack.update_attributes(:faltante => true)
    end
    flash[:notice] = "Updated packs!"
    redirect_to remitos_pedido_index_path
	end

  def upload
    @message = Pack.import(params[:file])
    if @message[0][:success].present?
      redirect_to packs_url, :flash => { :notice => @message[0][:message] }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pack

      @pack = Pack.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pack_params
      params.require(:pack).permit(:price, :name, :codigo, :description, :orden,
                                       :price_super, :marca, :supplier_id,
                                       :amount_allowed, :imagen,
                                       categoria_ids: [])
    end
end
