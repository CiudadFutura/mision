class InvitationMailer < ActionMailer::Base
  default from: "victoriacolectiva@gmail.com"

  def send_invitations(to_email, user)
    @email = to_email
    @coordinador = user
    mail(to: to_email, subject: 'Invitación a la Gran Misión Anti Infación')
  end

end
