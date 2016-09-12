class ComprasMailer < ActionMailer::Base
	default from: "victoriacolectiva@misionantiinflacion.com.ar"

	def new_cycle_close(coordinador, compra)
		@coordinador = coordinador
		@compra = compra
		puts @coordinador.to_yaml
		mail(to: coordinador.email, subject: '[Misión Anti Inflación] Nuevo ciclo de compra')
	end

end