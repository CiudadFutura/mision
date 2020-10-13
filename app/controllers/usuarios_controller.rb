class UsuariosController < ApplicationController
  before_action :set_usuario, only: [:show, :edit, :update, :destroy]
  authorize_resource

  # GET /usuarios
  # GET /usuarios.json
  def index
    @users = Usuario.all
    if params[:role].blank?
      params[:role] = Usuario::USUARIO
    end
    @usuarios = @users.by_roles(params[:role]).paginate(:page => params[:page], :per_page => 50)
    if params[:text_search].present?
      @usuarios = @users.search(params[:text_search]).paginate(:page => params[:page], :per_page => 50)
    end
    authorize! :index, @usuarios
    respond_to do |format|
      format.html
      format.csv { send_data @users.to_csv, filename: "#{Time.now.to_i}_usuarios.csv"}
      #format.csv { render csv: @users.to_csv, filename: "#{Time.now.to_i}_usuarios" }
    end
  end

  # GET /usuarios/1
  # GET /usuarios/1.json
  def show
    @circulo = Circulo.new if current_usuario.circulo.blank?
    if current_usuario.present? && current_usuario.admin?
      render 'usuarios/admin_show'
    end
  end


  # GET /usuarios/new
  def new
    @usuario = Usuario.new
  end

  # GET /usuarios/1/edit
  def edit
    respond_to do |format|
      if current_usuario.present? and current_usuario.admin?
        format.html { render 'usuarios/admin_edit' }
      else
        format.html
      end
    end
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
        format.html { redirect_to productos_url, notice: 'Usuario modificado exitosamente..' }
        format.json { render :show, status: :ok, location: productos_url }
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

  def set_circulo id
    @usuario.circulo = Circulo.find_by_coordinador_id(id)
    @usuario.save!
  end

  def finish_signup
    if request.patch? && params[:user] # Revisa si el request es de tipo patch, es decir, llenaron el formulario y lo ingresaron
      @usuario = Usuario.find(params[:id])

      if @usuario.update(user_params)
        sign_in(@user, :bypass => true)
        redirect_to root_path, notice: 'Hemos guardado tu email correctamente.'
      else
        @show_errors = true
      end
    end
  end

  def add_myself_cycle

    unless(params[:circulo_id].empty?)
      begin
        circulo = Circulo.find(params[:circulo_id])
      rescue ActiveRecord::RecordNotFound => e
        circulo = nil
      end

      if circulo.present?
        authorize! :add_myself_cycle, current_usuario

        if !circulo.completo? || circulo.special_type.present?
          current_usuario.circulo = circulo
          current_usuario.save!
          message = { notice: 'El usuario ha sido agregado a tu circulo.' }
        elsif !current_usuario.circulo.nil?
          message = { alert: 'El usuario ya pertenece a un circulo.' }
        elsif circulo.completo?
          message = { alert: 'El círculo esta completo.' }
        end
      else
        message = { alert: '¿Está seguro que es el número de círculo?.' }
      end
    else
      message = { alert: 'Tiene que ingresar el número de círculo' }
    end

    redirect_to usuario_path(current_usuario), message

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_usuario
      @usuario = Usuario.find(params[:id])
      if @usuario.identities.present?
        @profile = Usuario.koala(@usuario.identities(provider: 'facebook').first)
      end
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def usuario_params
      valid_params = [ :nombre, :apellido, :email, :calle, :codigo_postal,:ciudad, :pais, :tel1, :cel1, :dni,
                       :type,  :"fecha_de_nacimiento(1i)", :usuario_roles,
        :"fecha_de_nacimiento(2i)", :"fecha_de_nacimiento(3i)", :password, :password_confirmation, role_ids:[],
                       circulo_attributes:[:coordinador_id, :warehouse_id],
                       usuario_roles_attributes:[:usuario_id, :role_id, :warehouse_id]]
      valid_params << :circulo_id if current_usuario && current_usuario.admin?
      filtered_params = params.require(:usuario).permit(valid_params)
    end

end
