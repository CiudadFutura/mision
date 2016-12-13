class Identity < ActiveRecord::Base
	belongs_to :usuario
	validates_presence_of :uid, :provider
	validates_uniqueness_of :uid, scope: :provider

	def self.find_for_facebook_oauth(auth)
		identity = Identity.where(:provider => auth.provider, :uid => auth.uid).first
		if identity.nil?
			registered_user = Usuario.where(:email => auth.info.email).first
			unless registered_user.nil?
				Identity.create!(
						provider: auth.provider,
						uid: auth.uid,
						usuario_id: registered_user.id,
						email: auth.info.email,
						oauth_token: auth.credentials.token,
						oauth_expired_at: Time.at(auth.credentials.expires_at)
				)
			end
		end
		identity.usuario
	end

end