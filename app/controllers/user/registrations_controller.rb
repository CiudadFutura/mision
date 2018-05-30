class User::RegistrationsController < Devise::RegistrationsController
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
			usuario.skip_confirmation!
			usuario.confirm!
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

end

