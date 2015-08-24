class User::RegistrationsController < Devise::RegistrationsController
  protected

  def after_inactive_sign_up_path_for(resource)
    if(resource.try('coordinador?'))
      RegistrationMailer.invite(params[:email_invitado_1], resource).deliver unless params[:email_invitado_1].blank?
      RegistrationMailer.invite(params[:email_invitado_2], resource).deliver unless params[:email_invitado_2].blank?
      RegistrationMailer.invite(params[:email_invitado_3], resource).deliver unless params[:email_invitado_3].blank?
      RegistrationMailer.invite(params[:email_invitado_4], resource).deliver unless params[:email_invitado_4].blank?
    end
    super
  end
end