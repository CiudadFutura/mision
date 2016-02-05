class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy]

  # GET /reports
  # GET /reports.json
  def index
    if current_usuario.admin?
      @pedidos = Pedido.all
      if(params[:ciclo_id])
        @ciclo_id = 1
      end
      pedidos = Pedido.where(compra_id: 4)
      @hash_productos = Hash.new
      @reporte = {}
      pedidos.each do |pedido|
        JSON.parse(pedido.items).map do |i|
          supplier = Producto.find(i['producto_id']).supplier
          # Creates key for supplier if it doesn't exist
          unless @reporte.has_key?(supplier.id)
            @reporte[supplier.id] = {name: supplier.name, products: []}
          end


          # If the product exist on the report sums, if it's new it assignes
          if @reporte.has_key?(supplier.id) && yaml[:products].has_key?(i['producto_id'])
            @reporte[supplier.id][:products][i['producto_id']] += i['cantidad']
          else
            @reporte[supplier.id][:products][i['producto_id']] = i['cantidad']
          end

        end
      end
      # @bueno = @bueno.group_by{'prod'}
      @bueno.group_by{ |h| h[:id_p] }.map do |_, hash|
        hash.reduce do |hash_a, hash_b|
          hash_a.merge(hash_b){ |key, old, new| key == :id_p ? old : old + new }
        end
      end
    end
    return @hash_productos
  end


  # GET /reports/1
  # GET /reports/1.json
  def show
  end

  # GET /reports/new
  def new
    @report = Report.new
  end

  # GET /reports/1/edit
  def edit
  end

  # POST /reports
  # POST /reports.json
  def create
    @report = Report.new(report_params)

    respond_to do |format|
      if @report.save
        format.html { redirect_to @report, notice: 'Report was successfully created.' }
        format.json { render :show, status: :created, location: @report }
      else
        format.html { render :new }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reports/1
  # PATCH/PUT /reports/1.json
  def update
    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to @report, notice: 'Report was successfully updated.' }
        format.json { render :show, status: :ok, location: @report }
      else
        format.html { render :edit }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @report.destroy
    respond_to do |format|
      format.html { redirect_to reports_url, notice: 'Report was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def report_params
      params[:report]
    end
end
