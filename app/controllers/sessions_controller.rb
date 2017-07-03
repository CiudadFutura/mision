class SessionsController < ApplicationController
  def create
    puts auth_hash.to_yaml
    puts 'carajo'
    if auth_hash
      puts auth_hash.to_yaml
      identity = Identity.where(provider: auth_hash.provider, uid: auth_hash.uid).first
      if identity
        user = Usuario.find_by(id: identity.usuario_id)
        identity.update_attributes!(
          token: auth_hash.credentials.token,
          secret: auth_hash.credentials.secret,
          expires_at: expires_at
        )
      else
        user = usuario_signed_in? ? current_usuario : Usuario.create(nombre: auth_hash.info.name, email: auth_hash.info.email)
        Identity.create(
          provider: auth_hash.provider,
          uid: auth_hash.uid,
          token: auth_hash.credentials.token,
          secret: auth_hash.credentials.secret,
          expires_at: expires_at,
          usuario_id: user.id
        )
      end
      session[:user_id] = user.id unless usuario_signed_in?
    end
    redirect_to root_path
  end

  private

  def auth_hash
    request.env["omniauth.auth"]
  end

  def expires_at
    if auth_hash.credentials.expires_at.present?
      Time.at(auth_hash.credentials.expires_at).to_datetime
    elsif auth_hash.credentials.expires_in.present?
      DateTime.now + auth_hash.credentials.expires_in.to_i.seconds
    end
  end
end