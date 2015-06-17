class ExampleMailer < ActionMailer::Base
  default from: "victoriacolectiva@misionantiinflacion.com.ar"

  def sample_email()
    mail(to: 'andres.cachero@gmail.com', subject: 'Sample Email')
  end

end
