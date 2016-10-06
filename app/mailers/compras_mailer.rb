class ComprasMailer < ActionMailer::Base
	default from: "victoriacolectiva@misionantiinflacion.com.ar"

	def new_cycle_close(coordinador, compra)
		@coordinador = coordinador
		@compra = compra
		mail(to: coordinador.email, subject: '[Misión Anti Inflación] Nuevo ciclo de compra')
	end

	def remember_cycle(coordinador, compra)
		@coordinador = coordinador
		@compra = compra

		mail(to: coordinador.email, subject: '[Misión Anti Inflación] Recuerda')
	end


end