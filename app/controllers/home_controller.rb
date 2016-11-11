class HomeController < ApplicationController
  layout "layout"

  def index
    user_type = current_usuario.nil? ? 'Guess' : current_usuario.type
    if !current_usuario.blank? and !current_usuario.admin? and current_usuario.account.blank?
      create_current_account
		end
    case user_type
      when Usuario::ADMIN
        redirect_to dashboards_path
			when Usuario::COORDINADOR
				circulo = Circulo.find(current_usuario.circulo_id)
				@compra = circulo.next_delivery

				respond_to do |format|

					format.html {render 'home/home_coord'}
					format.json { render json: @compra.as_json }

				end
			when Usuario::USUARIO
				circulo = Circulo.find(current_usuario.circulo_id)
				@compra = circulo.next_delivery

				respond_to do |format|

					format.html {render 'home/home_user'}
					format.json { render json: @compra.as_json }

				end
    end
  end
end

private
# Use callbacks to share common setup or constraints between actions.
def create_current_account
  account = Account.new
  account.usuario_id = current_usuario.id
  account.status = true
  account.balance = 0
  account.save
end