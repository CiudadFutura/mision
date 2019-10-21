class CirculosController < ApplicationController
  before_action :set_circulo, only: [:show, :edit, :update, :destroy]
  authorize_resource except: [:abandonar]

  # GET /circulos
  # GET /circulos.json
  def index

    if current_usuario && current_usuario.admin?
      @todos = Circulo.all
      if params[:text_search].present?
        @circulos = @todos.search(params[:text_search]).paginate(page: params[:page], per_page: 50)
      else
        @circulos = @todos.paginate(page: params[:page], per_page: 50)
      end
      respond_to do |format|
        format.html {render 'circulos/index_admin'}
        format.csv { send_data @todos.to_csv, filename: "#{Time.now.to_i}_circulos"}
        #format.csv { render csv: @todos.to_csv, filename: "#{Time.now.to_i}_circulos" }
      end
    else
      @circulos = Circulo.paginate(page: params[:page], per_page: 10)
    end


  end

  # GET /circulos/1
  # GET /circulos/1.json
  def show
    if current_usuario && current_usuario.admin?

      respond_to do |format|
        format.html
        format.csv { send_data @circulo.to_csv, filename: "#{Time.now.to_i}_circulos"}
        #format.csv { render csv: @circulo.to_csv, filename: "#{Time.now.to_i}_circulos" }
      end
    else
      redirect_to action: 'show', controller: :usuarios, id: current_usuario
    end
  end

  # GET /circulos/new
  def new
    @circulo = Circulo.new
  end

  # GET /circulos/1/edit
  def edit
    respond_to do |format|
      if current_usuario.present? and current_usuario.admin?
        format.html { render 'circulos/admin_edit' }
      else
        format.html
      end
    end
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


  def add_usuario
    unless(params[:usuario_id].empty?)
      circulo = Circulo.find(params[:circulo_id])
      authorize! :add_usuario, circulo
      usuario = Usuario.find(params[:usuario_id])
      #InvitationMailer.send_confirmation_circle(usuario, current_usuario).deliver
      if usuario.circulo.nil? && !circulo.completo? or circulo.special_type.present?
        usuario.circulo = circulo
        token = Devise.friendly_token
        usuario.confirmation_circle_sent_at = DateTime.now
        usuario.confirmation_token_circle = token
        usuario.save!
        #InvitationMailer.send_confirmation_circle(usuario, circulo)
        message = { notice: "El usuario ha sido agregado a tu circulo." }
      elsif !usuario.circulo.nil?
        message = { alert: "Error: El usuario ya pertenece a un circulo." }
      elsif circulo.completo?
        message = { alert: "Error: El circulo esta completo." }
      end
    else
        message = { alert: "Error: Debe ingresar el numero de usuario." }
    end
    if current_usuario.admin?
      redirect_to circulo_path(circulo), message
    else
      redirect_to usuario_path(current_usuario), message
    end
  end

  def remove_usuario
    circulo = Circulo.find(params[:circulo_id])
    authorize! :remove_usuario, circulo
    usuario = Usuario.find(params[:usuario_id])
    usuario.circulo = nil
    usuario.save!
    if current_usuario.admin?
      redirect_to circulo_path(circulo), notice: 'El usuario ha sido eliminado del circulo.'
    else
      redirect_to usuario_path(current_usuario), notice: 'El usuario ha sido eliminado del circulo.'
    end
  end

  def circle_accepted_confirmation

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
      params.require(:circulo).permit(:coordinador_id, :warehouse_id, :special_type)
    end
end
