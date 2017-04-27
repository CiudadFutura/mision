class HomeController < ApplicationController
  layout "layout"

  def index
    user_type = current_usuario.nil? ? 'Guess' : current_usuario.type
		@ciclo_actual = Compra::ciclo_actual
    if !current_usuario.blank? and !current_usuario.admin? and current_usuario.account.blank?
      create_current_account
		end
    case user_type
			when Usuario::ADMIN
				@pedidosCiclos = Pedido::pedidos_ciclos
				@coordinadoresNuevos = Usuario::nuevos_coordinadores
        @countProductsByCycle = Compra::products_by_cycles
        @total_sales_per_year = Compra::sales_totals_per_year
        @total_users = Usuario::new_users_per_month
        @total_new_users_per_year = Usuario::users_totals_per_year
				page = 'home/home_admin'
			when Usuario::COORDINADOR
				if current_usuario.circulo_id.present?
					circulo = Circulo.find(current_usuario.circulo_id)
					@compra = circulo.next_delivery
				end
				page = 'home/home_coord'
			when Usuario::USUARIO
				if current_usuario.circulo_id.present?
					circulo = Circulo.find(current_usuario.circulo_id)
					@compra = circulo.next_delivery
				end
				page = 'home/home_user'
		end
		respond_to do |format|

			format.html {render page }
			format.json { render json: @compra.as_json }

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