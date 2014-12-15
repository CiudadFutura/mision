class HomeController < ApplicationController
  def index
    user_type = current_usuario.nil? ? 'Guess' : current_usuario.type
    case user_type
    when Usuario::ADMIN
      render 'home_coord'
    when Usuario::COORDINADOR
      render 'home_coord'
    when Usuario::USUARIO
      redirect_to productos_path
    else
      redirect_to productos_path
    end
  end
end