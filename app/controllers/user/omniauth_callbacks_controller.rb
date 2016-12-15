class User::OmniauthCallbacksController < Devise::OmniauthCallbacksController

	def facebook
		@usuario = Identity.find_for_facebook_oauth(request.env["omniauth.auth"])

		if @usuario.persisted?
			session['devise.facebook_data'] = request.env["omniauth.auth"]
			redirect_to usuario_path(@usuario)
		else
			redirect_to '/'
		end
	end
end