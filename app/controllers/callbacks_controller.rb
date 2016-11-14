class CallbacksController < Devise::OmniauthCallbacksController
	def facebook
		@usuario = Usuario.from_omniauth(request.env["omniauth.auth"])
		sign_in_and_redirect @usuario
	end
end