class UsuariosController < ApplicationController
  before_action :set_usuario, only: [:show, :edit, :update, :destroy]
  authorize_resource

  # GET /usuarios
  # GET /usuarios.json
  def index
    @usuarios = Usuario.all
    authorize! :index, @usuarios
    respond_to do |format|
      format.html
      format.csv { render csv: @usuarios.to_csv, filename: "#{Time.now.to_i}_usuarios" }
    end
  end

  # GET /usuarios/1
  # GET /usuarios/1.json
  def show
    @ciclo_actual = Compra::ciclo_actual
    @ciclo_actual_completo = Compra::ciclo_actual_completo
  end


  # GET /usuarios/new
  def new
    @usuario = Usuario.new
  end

  # GET /usuarios/1/edit
  def edit
  end

  # POST /usuarios
  # POST /usuarios.json
  def create
    @usuario = Usuario.new(usuario_params)

    respond_to do |format|
      if @usuario.save
        format.html { redirect_to @usuario, notice: 'Usuario creado exitosamente.' }
        format.json { render :show, status: :created, location: @usuario }
      else
        format.html { render :new }
        format.json { render json: @usuario.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /usuarios/1
  # PATCH/PUT /usuarios/1.json
  def update
    respond_to do |format|
      if @usuario.update(usuario_params)
        format.html { redirect_to @usuario, notice: 'Usuario modificado exitosamente..' }
        format.json { render :show, status: :ok, location: @usuario }
      else
        format.html { render :edit }
        format.json { render json: @usuario.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /usuarios/1
  # DELETE /usuarios/1.json
  def destroy
    @usuario.destroy
    respond_to do |format|
      format.html { redirect_to usuarios_url, notice: 'Usuario eliminado exitosamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_usuario
      @usuario = Usuario.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def usuario_params
      valid_params = [ :nombre, :apellido, :email, :calle, :codigo_postal,
        :ciudad, :pais, :tel1, :cel1, :type, :"fecha_de_nacimiento(1i)",
        :"fecha_de_nacimiento(2i)", :"fecha_de_nacimiento(3i)" ]
      valid_params << :circulo_id if current_usuario && current_usuario.admin?
      filtered_params = params.require(:usuario).permit(valid_params)
    end
end
