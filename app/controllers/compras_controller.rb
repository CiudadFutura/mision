class ComprasController < ApplicationController
  before_action :set_compra, only: [:show, :edit, :update, :destroy, :send_email, :refresh_status]
  authorize_resource

  # GET /compras
  # GET /compras.json
  def index
    if current_usuario && current_usuario.admin?
      @compras = Compra.paginate(page: params[:page], per_page: 10).order(fecha_inicio_compras: :desc).limit(6)
      render 'compras/index_admin'
    else
      @compras = Compra.cycles_list.limit(6)
      @compras = Compra.order(fecha_inicio_compras: :desc).limit(6) if @compras.blank?
    end
  end

  # GET /compras/1
  # GET /compras/1.json
  def show
    @circulos = @compra.get_deliveries
		@statuses = @compra.get_statuses
  end

  # GET /compras/new
  def new
    @compra = Compra.new
  end

  # GET /compras/1/edit
  def edit
    if params[:previuos].present?
      @source = Compra.find(params[:previuos])
      @circulos = {}
      @source.deliveries.each do |delivery|
        @circulos[delivery.circulo_id] = delivery.clone
      end
    end
  end

	def clone
		@source = Compra.find(params[:id])
		@compra = @source.dup

    if @compra.save
      redirect_to action: 'edit', id:@compra.id, previuos: @source.id
    end
	end

  # POST /compras
  # POST /compras.json
  def create
    @compra = Compra.new(compra_params)
    respond_to do |format|
      if @compra.save
        format.html { redirect_to @compra, notice: 'Ciclo creado exitosamente.' }
        format.json { render :show, status: :created, location: @compra }
      else
        format.html { render :new }
        format.json { render json: @compra.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /compras/1
  # PATCH/PUT /compras/1.json
  def update
    respond_to do |format|
      if @compra.update(compra_params)
        format.html { redirect_to @compra, notice: 'Ciclo modificado exitosamente..' }
        format.json { render :show, status: :ok, location: @compra }
      else
        format.html { render :edit }
        format.json { render json: @compra.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /compras/1
  # DELETE /compras/1.json
  def destroy
    respond_to do |format|
      format.html { redirect_to compras_url, notice: 'Ciclo eliminado exitosamente.' }
      format.json { head :no_content }
    end
  end

  def add_status

		deliveryStatus = DeliveryStatus.where('delivery_id = ? AND sector_id = ? AND status_id = ?',
																					params[:id_delivery], params[:id_sector], params[:new_status]).order('updated_at').last
		@compra = Compra.find(params[:id])

    if deliveryStatus.blank?
				deliveryStatus = DeliveryStatus.new
				deliveryStatus.delivery_id = params[:id_delivery]
				deliveryStatus.sector_id = params[:id_sector]
				deliveryStatus.status_id = params[:new_status]
				flash[:notice] = 'Estado correctamente creado.' if deliveryStatus.save
		else
				deliveryStatus.status_id = params[:new_status]
				flash[:notice] = 'Estado correctamente editado.' if deliveryStatus.save
		end
    @circulos = @compra.get_deliveries

    render 'status'

  end

	def send_email
		new_cycle = '1'
		remember_cycle = '2'
		tipo_mail = params[:envio_email]
		@compra.deliveries.each do |delivery|
			coordinador = delivery.circulo.usuarios.find(delivery.circulo.coordinador_id)
			sleep(1)
			if tipo_mail[:tipo_email] == new_cycle
				ComprasMailer.new_cycle_close(coordinador, @compra).deliver
			end
			if tipo_mail[:tipo_email] == remember_cycle
				ComprasMailer.remember_cycle(coordinador, @compra).deliver
			end
		end
		respond_to do |format|
			format.js { render nothing: true }
		end
	end

  def refresh_status
    @circulos = @compra.get_deliveries
    render 'status'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_compra
      @compra = Compra.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def compra_params
      filtered_params = params.require(:compra).permit(:nombre, :descripcion, :tipo,
        :fecha_inicio_compras => [:year, :month, :day, :hour, :minute],
        :fecha_fin_compras => [:year, :month, :day, :hour, :minute],
        :fecha_fin_pagos => [:year, :month, :day, :hour, :minute],
        :fecha_entrega_compras => [:year, :month, :day, :hour, :minute],
        circulo_ids:[], warehouse_ids:[])
      { nombre: filtered_params[:nombre],
        descripcion: filtered_params[:descripcion],
				tipo: filtered_params[:tipo],
        circulo_ids: filtered_params["circulo_ids"],
        warehouse_ids: filtered_params["warehouse_ids"],
        fecha_inicio_compras: Time.zone.local(
          filtered_params[:fecha_inicio_compras][:year],
          filtered_params[:fecha_inicio_compras][:month],
          filtered_params[:fecha_inicio_compras][:day],
          filtered_params[:fecha_inicio_compras][:hour],
          filtered_params[:fecha_inicio_compras][:minute]),
        fecha_fin_compras: Time.zone.local(
          filtered_params[:fecha_fin_compras][:year],
          filtered_params[:fecha_fin_compras][:month],
          filtered_params[:fecha_fin_compras][:day],
          filtered_params[:fecha_fin_compras][:hour],
          filtered_params[:fecha_fin_compras][:minute]),
        fecha_fin_pagos: Time.zone.local(
          filtered_params[:fecha_fin_pagos][:year],
          filtered_params[:fecha_fin_pagos][:month],
          filtered_params[:fecha_fin_pagos][:day],
          filtered_params[:fecha_fin_pagos][:hour],
          filtered_params[:fecha_fin_pagos][:minute]),
        fecha_entrega_compras: Time.zone.local(
          filtered_params[:fecha_entrega_compras][:year],
          filtered_params[:fecha_entrega_compras][:month],
          filtered_params[:fecha_entrega_compras][:day],
          filtered_params[:fecha_entrega_compras][:hour],
          filtered_params[:fecha_entrega_compras][:minute])}
    end
end
