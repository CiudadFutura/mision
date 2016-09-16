class ComprasController < ApplicationController
  before_action :set_compra, only: [:show, :edit, :update, :destroy]
  authorize_resource

  # GET /compras
  # GET /compras.json
  def index
    @compras = Compra.all.order(fecha_inicio_compras: :desc)
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
    @compra.destroy
    respond_to do |format|
      format.html { redirect_to compras_url, notice: 'Ciclo eliminado exitosamente.' }
      format.json { head :no_content }
    end
  end

  def add_status
		deliveryStatus = DeliveryStatus.where('delivery_id = ? AND sector_id = ?',
                                            params[:id_delivery], params[:id_sector])

    @compra = Compra.find(params[:id])

    if deliveryStatus.blank?

        deliveryStatus = DeliveryStatus.new
        deliveryStatus.delivery_id = params[:id_delivery]
        deliveryStatus.sector_id = params[:id_sector]
        deliveryStatus.status_id = params[:new_status]
        flash[:notice] = 'Estado correctamente creado.' if deliveryStatus.save!
    else
      deliveryStatus.first.status_id = params[:new_status]
      flash[:notice] = 'Estado correctamente editado.' if deliveryStatus.first.save
    end
    @circulos = @compra.get_deliveries

    render 'status'

  end

  def refresh_status
    @compra = Compra.find(params[:id])
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
      filtered_params = params.require(:compra).permit(:nombre, :descripcion, 
        :fecha_inicio_compras => [:year, :month, :day, :hour, :minute],
        :fecha_fin_compras => [:year, :month, :day, :hour, :minute],
        :fecha_fin_pagos => [:year, :month, :day, :hour, :minute],
        :fecha_entrega_compras => [:year, :month, :day, :hour, :minute],
        circulo_ids:[])
      { nombre: filtered_params[:nombre],
        descripcion: filtered_params[:descripcion],
        circulo_ids: filtered_params["circulo_ids"],
        fecha_inicio_compras: Time.utc(
          filtered_params[:fecha_inicio_compras][:year],
          filtered_params[:fecha_inicio_compras][:month],
          filtered_params[:fecha_inicio_compras][:day],
          filtered_params[:fecha_inicio_compras][:hour],
          filtered_params[:fecha_inicio_compras][:min]),
        fecha_fin_compras: Time.utc(
          filtered_params[:fecha_fin_compras][:year],
          filtered_params[:fecha_fin_compras][:month],
          filtered_params[:fecha_fin_compras][:day],
          filtered_params[:fecha_fin_compras][:hour],
          filtered_params[:fecha_fin_compras][:min]),
        fecha_fin_pagos: Time.utc(
          filtered_params[:fecha_fin_pagos][:year],
          filtered_params[:fecha_fin_pagos][:month],
          filtered_params[:fecha_fin_pagos][:day],
          filtered_params[:fecha_fin_pagos][:hour],
          filtered_params[:fecha_fin_pagos][:min]),
        fecha_entrega_compras: Time.utc(
          filtered_params[:fecha_entrega_compras][:year],
          filtered_params[:fecha_entrega_compras][:month],
          filtered_params[:fecha_entrega_compras][:day],
          filtered_params[:fecha_entrega_compras][:hour],
          filtered_params[:fecha_entrega_compras][:min])}
    end
end
