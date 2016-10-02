class ComprasMailer < ActionMailer::Base
	default from: "victoriacolectiva@misionantiinflacion.com.ar"

	def new_cycle_close(coordinador, compra)
		@coordinador = coordinador
		@compra = compra
		path = Rails.root.join('app','assets','images')
		#logo mision
		attachments.inline['headerlogo'] = File.read(path.join('logoM.png'))
		#logo canasta
		attachments.inline['headerbasket'] = File.read(path.join('canasta.png'))
		#logo calendario
		attachments.inline['bodycalendar'] = File.read(path.join('calendario.png'))
		#logos comunicacion
		attachments.inline['bodycomunication'] = File.read(path.join('iconosComunicacion.png'))
		#logo CF equipo
		attachments.inline['footerteam'] = File.read(path.join('cfLogo.png'))
		#logo face
		attachments.inline['footerface'] = File.read(path.join('faceLogo.png'))
		#logo web
		attachments.inline['footerwwww'] = File.read(path.join('www.png'))


		mail(to: coordinador.email, subject: '[Misión Anti Inflación] Nuevo ciclo de compra')
	end

end