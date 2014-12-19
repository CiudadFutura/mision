class CategoriasController < ApplicationController
  before_action :set_categoria, only: [:show, :edit, :update, :destroy]

  # GET /categoria
  # GET /categoria.json
  def index
    @categorias = Categoria.all
  end

  # GET /categoria/1
  # GET /categoria/1.json
  def show
  end

  # GET /categoria/new
  def new
    @categoria = Categoria.new
  end

  # GET /categoria/1/edit
  def edit
  end

  # POST /categoria
  # POST /categoria.json
  def create
    @categoria = Categoria.new(categoria_params)

    respond_to do |format|
      if @categoria.save
        format.html { redirect_to @categoria, notice: 'categoria was successfully created.' }
        format.json { render :show, status: :created, location: @categoria }
      else
        format.html { render :new }
        format.json { render json: @categoria.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categoria/1
  # PATCH/PUT /categoria/1.json
  def update
    respond_to do |format|
      if @categoria.update(categoria_params)
        format.html { redirect_to @categoria, notice: 'categoria was successfully updated.' }
        format.json { render :show, status: :ok, location: @categoria }
      else
        format.html { render :edit }
        format.json { render json: @categoria.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categoria/1
  # DELETE /categoria/1.json
  def destroy
    @categoria.destroy
    respond_to do |format|
      format.html { redirect_to categorias_url, notice: 'categoria was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_categoria
      @categoria = Categoria.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def categoria_params
      params.require(:categoria).permit(:nombre, :descripcion)
    end
end
