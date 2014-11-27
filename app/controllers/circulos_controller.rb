class CirculosController < ApplicationController
  before_action :set_circulo, only: [:show, :edit, :update, :destroy]

  # GET /circulos
  # GET /circulos.json
  def index
    @circulos = Circulo.all
  end

  # GET /circulos/1
  # GET /circulos/1.json
  def show
  end

  # GET /circulos/new
  def new
    @circulo = Circulo.new
  end

  # GET /circulos/1/edit
  def edit
  end

  # POST /circulos
  # POST /circulos.json
  def create
    @circulo = Circulo.new(circulo_params)

    respond_to do |format|
      if @circulo.save
        format.html { redirect_to @circulo, notice: 'Circulo was successfully created.' }
        format.json { render :show, status: :created, location: @circulo }
      else
        format.html { render :new }
        format.json { render json: @circulo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /circulos/1
  # PATCH/PUT /circulos/1.json
  def update
    respond_to do |format|
      if @circulo.update(circulo_params)
        format.html { redirect_to @circulo, notice: 'Circulo was successfully updated.' }
        format.json { render :show, status: :ok, location: @circulo }
      else
        format.html { render :edit }
        format.json { render json: @circulo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /circulos/1
  # DELETE /circulos/1.json
  def destroy
    @circulo.destroy
    respond_to do |format|
      format.html { redirect_to circulos_url, notice: 'Circulo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_circulo
      @circulo = Circulo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def circulo_params
      params.require(:circulo).permit(:coordinador_id)
    end
end
