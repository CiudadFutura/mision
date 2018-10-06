class CirculosController < ApplicationController
  before_action :set_circulo, only: [:show, :edit, :update, :destroy]
  authorize_resource except: [:abandonar]

  # GET /circulos
  # GET /circulos.json
  def index

    if current_usuario && current_usuario.admin?
      @circulos = Circulo.paginate(page: params[:page], per_page: 10)
      respond_to do |format|
        format.html {render 'circulos/index_admin'}
        format.csv { render csv: @circulos.to_csv, filename: "#{Time.now.to_i}_circulos" }
      end
    else
      @circulos = Circulo.paginate(page: params[:page], per_page: 10)
    end


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
        if !current_usuario.coordinador? and !current_usuario.admin?
          usuario_role = UsuarioRole.new(usuario_id: current_usuario.id,
                                         role_id: Role.find_by_name(Usuario::COORDINADOR).id,
                                         created_at: Time.now,
                                         updated_at: Time.now)
          usuario_role.save
        end
        @circulo.coordinador.circulo = @circulo
        @circulo.coordinador.save!

        InvitationMailer.send_invitations(params[:email_invitado_1], current_usuario).deliver unless params[:email_invitado_1].blank?
        InvitationMailer.send_invitations(params[:email_invitado_2], current_usuario).deliver unless params[:email_invitado_2].blank?
        InvitationMailer.send_invitations(params[:email_invitado_3], current_usuario).deliver unless params[:email_invitado_3].blank?
        InvitationMailer.send_invitations(params[:email_invitado_4], current_usuario).deliver unless params[:email_invitado_4].blank?

        format.html { redirect_to @circulo, notice: 'Circulo creado exitosamente.' }
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
        if @circulo.coordinador.circulo.nil?
          @circulo.coordinador.circulo = @circulo
          @circulo.coordinador.save!
        end

        format.html { redirect_to @circulo, notice: 'Circulo modificado exitosamente..' }
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
      format.html { redirect_to circulos_url, notice: 'Circulo eliminado exitosamente.' }
      format.json { head :no_content }
    end
  end

  def search
    @circulos = Circulo.where("warehouse_id = ?", params[:warehouse_id])

     render :partial => 'compras/show_circles'

  end

  def add_usuario
    unless(params[:usuario_id].empty?)
      circulo = Circulo.find(params[:circulo_id])
      authorize! :add_usuario, circulo
      usuario = Usuario.find(params[:usuario_id])
      if usuario.circulo.nil? && !circulo.completo?
        usuario.circulo = circulo
        usuario.save!
        message = { notice: "El usuario a sido agregado a tu circulo." }
      elsif !usuario.circulo.nil?
        message = { alert: "Error: El usuario ya pertenece a un circulo." }
      elsif circulo.completo?
        message = { alert: "Error: El circulo esta completo." }
      end
    else
        message = { alert: "Error: Debe ingresar el numero de usuario." }
    end

    redirect_to usuario_path(current_usuario), message
  end

  def remove_usuario
    circulo = Circulo.find(params[:circulo_id])
    authorize! :remove_usuario, circulo
    usuario = Usuario.find(params[:usuario_id])
    usuario.circulo = nil
    usuario.save!
    redirect_to usuario_path(current_usuario), notice: "El usuario a sido eliminado del circulo."
  end

  def abandonar
    authorize! :abandonar_circulo, current_usuario
    current_usuario.circulo = nil
    current_usuario.save!
    message = { notice: "Haz abandonado el circulo. Recuerda ingresar en uno antes de hacer tu proximo pedido" }
    redirect_to usuario_path(current_usuario), message
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_circulo
      @circulo = Circulo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def circulo_params
      params.require(:circulo).permit(:coordinador_id, :warehouse_id)
    end
end
