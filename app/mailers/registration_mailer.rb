class RegistrationMailer < ActionMailer::Base
  default from: "victoriacolectiva@gmail.com"

  def invite(to_email, coordinador)
    @email = to_email
    @coordinador = coordinador
    mail(to: to_email, subject: 'Invitacion a la Gran Misión')
  end

end
