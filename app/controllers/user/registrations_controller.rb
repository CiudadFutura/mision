class User::RegistrationsController < Devise::RegistrationsController
  prepend_before_action :require_no_authentication, only: [:new, :create, :cancel, ]
  prepend_before_action :authenticate_scope!, :only => [:edit, :update, :destroy]

  before_action :configure_permitted_parameters

  prepend_view_path 'app/views/devise'

  # GET /resource/sign_up
  def new
    build_resource({})
    respond_with self.resource
  end

  def create
    build_resource(sign_up_params)
    #Verifying Captcha
    if !verify_recaptcha(model: resource)
      if resource.save
        if resource.active_for_authentication?
          set_flash_message :notice, :signed_up if is_navigational_format?
          sign_up(resource_name, resource)
          respond_with resource, :location => after_sign_up_path_for(resource)
        else
          set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
          expire_data_after_sign_in!
          respond_with resource, :location => after_inactive_sign_up_path_for(resource)
        end
      else
        clean_up_passwords resource

        response_to_sign_up_failure resource

      end
    else
      super
    end
  end

  protected

  def after_inactive_sign_up_path_for(resource)
    create_current_account(resource)
    if(resource.try('coordinador?'))
      RegistrationMailer.invite(params[:email_invitado_1], resource).deliver unless params[:email_invitado_1].blank?
      RegistrationMailer.invite(params[:email_invitado_2], resource).deliver unless params[:email_invitado_2].blank?
      RegistrationMailer.invite(params[:email_invitado_3], resource).deliver unless params[:email_invitado_3].blank?
      RegistrationMailer.invite(params[:email_invitado_4], resource).deliver unless params[:email_invitado_4].blank?
      circulo = Circulo.create!(coordinador_id: resource.id )
      circulo.warehouse_id = params[:usuario][:warehouse_id][:warehouse_id]
      circulo.save
      usuario = resource
      usuario.circulo = circulo
      usuario.save!
		else
			usuario = resource
			usuario.save!
    end
    super
	end

  def create_current_account(resource)
    account = Account.new
    account.usuario_id = resource.id
    account.status = true
    account.balance = 0
    account.save
  end

  private

  def response_to_sign_up_failure(resource)
    if resource.email == "" && resource.password == nil
      set_flash_message :alert, :"Ingrese los campos requeridos"
      redirect_to new_usuario_registration_path
    elsif Usuario.pluck(:email).include? resource.email
      flash[:alert] = 'El email ingresado ya existe'
      redirect_to new_usuario_registration_path
    end
  end

end

