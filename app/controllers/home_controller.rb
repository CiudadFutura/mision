class HomeController < ApplicationController
  layout "layout"

  def index
    user_type = current_usuario.nil? ? 'Guess' : current_usuario.type
    case user_type
      when Usuario::ADMIN
        redirect_to dashboards_path
      when Usuario::COORDINADOR
        render 'home_coord'
      when Usuario::USUARIO
        redirect_to productos_path
    end
  end
end
