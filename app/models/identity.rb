class Identity < ActiveRecord::Base
  belongs_to :usuario
  belongs_to :supplier

  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider

  def self.find_for_oauth(auth)
    puts auth.to_yaml
    identity = find_by(provider: auth.provider, uid: auth.uid)
    identity = create(uid: auth.uid, provider: auth.provider) if identity.nil?
    identity.usuario_id = current_usuario.id
    identity.token = auth.credentials.token
    identity.refresh_token = auth.credentials.refresh_token
    identity.expires_at = auth.credentials.expires_at
    identity.name = auth.info.name
    identity.email = auth.info.email
    identity.nickname = auth.info.nickname
    identity.image = auth.info.image
    identity.phone = auth.info.phone
    identity.urls = (auth.info.urls || "").to_json
    identity.save
    identity
  end

end
