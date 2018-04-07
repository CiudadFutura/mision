class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def instagram
    generic_callback( 'instagram' )
  end

  def facebook_test
    @user = User.find_for_oauth(env["omniauth.auth"], current_user)

    if @user.persisted? # Chequea que nuestro usuario se haya guardado en la base de datos y no sea una instancia superficial
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "facebook".capitalize) if is_navigational_format?
    else
      session["devise.facebook_data"] = env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def facebook
    generic_callback( 'facebook' )
  end

  def twitter
    generic_callback( 'twitter' )
  end

  def google_oauth2
    generic_callback( 'google_oauth2' )
  end

  def generic_callback( provider )
    puts env["omniauth.auth"]
    puts provider
    @identity = Identity.find_for_oauth env['omniauth.auth']

    @user = @identity.user || current_user
    if @user.nil?
      @user = User.create( email: @identity.email || '' )
      @identity.update_attribute( :user_id, @user.id )
    end

    if @user.email.blank? && @identity.email
      @user.update_attribute( :email, @identity.email)
    end

    if @user.persisted?
      @identity.update_attribute( :user_id, @user.id )
      # This is because we've created the user manually, and Device expects a
      # FormUser class (with the validations)
      @user = FormUser.find @user.id
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: provider.capitalize) if is_navigational_format?
    else
      session["devise.#{provider}_data"] = env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def after_sign_in_path_for(resource) # Revisa después de cada login si el mail del usuario es válido
    if resource.email_verified?
      super resource # Acción por defecto de Devise (si no está configurada, va al root_path)
    else
      finish_signup_path(resource)
    end
  end

end