class HomeController < ApplicationController
  #home.html.erb exists
  layout "home"

  def index

    user_type = current_usuario.nil? ? 'Guess' : current_usuario.type
    case user_type
      when Usuario::ADMIN
        render 'home_admin'
      when Usuario::COORDINADOR
        render 'home_coord'
      when Usuario::USUARIO
        redirect_to productos_path
    end
  end
end
