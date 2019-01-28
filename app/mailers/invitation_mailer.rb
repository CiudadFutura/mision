class InvitationMailer < ActionMailer::Base
  default from: "victoriacolectiva@gmail.com"

  def send_invitations(to_email, user)
    @email = to_email
    @coordinador = user
    mail(to: to_email, subject: 'Invitación a la Gran Misión Anti Inflación')
  end

  def send_confirmation_circle(to_usuario, user)
    @user = to_usuario
    @coordinador = user
    mail(to: @user.email, subject: 'Confirmación círculo - Misión Anti Inflación  ')
  end

end
