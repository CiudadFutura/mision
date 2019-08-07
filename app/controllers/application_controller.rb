class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  rescue_from ActionController::RoutingError, :with => :render_404

  before_action :init_carrito
  before_action :categorias_menu
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :get_current_cycle

  layout :choose_layout

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def current_ability
    @current_ability ||= Ability.new(current_usuario)
  end

  def user_for_paper_trail
    current_usuario ? current_usuario.id : 'Public user'
  end

  def init_carrito
    @carrito = Cart.new(session)
  end

  def categorias_menu
    @categorias_menu = Rails.cache.fetch('categorias_menu') do
      menu = []
      Categoria.where(parent_id: 'NULL').each do |cat_parent|
        cat = {
                id: cat_parent.id,
                nombre: cat_parent.nombre,
                subcategorias: []
              }
        cat_parent.subcategorias.each do |subcategoria|
          cat[:subcategorias] << {
            id: subcategoria.id,
            nombre: subcategoria.nombre,
            parent_id: subcategoria.parent_id
          }
        end
        menu << cat
      end
      menu
    end
  end

  def get_current_cycle
    @current_cycle_complete = Compra.ciclo_actual_completo
    @current_cycle = Compra.ciclo_actual
    @current_user_warehouse = current_usuario.circulo.warehouse_id if current_usuario.present? and current_usuario.circulo.present?
    @consumer_enabled_purchase = current_usuario.purchase_enabled?(@current_cycle) if current_usuario.present? and @current_cycle.present?
    @current_cycle_complete = @current_cycle_complete.first if @current_cycle_complete.present?
    @current_cycle = @current_cycle.first if @current_cycle.present?
    @current_warehouses_ids = @current_cycle.warehouses.map{|warehouse| "#{warehouse.id}"}.join(",") if @current_cycle.present? and @current_cycle.warehouses.present? and current_usuario.present?
  end

  protected

  def choose_layout
    if signed_in?
      if !current_usuario.admin?
        'layout'
      else
        'admin_layout'
      end
    else
      'layout'
    end
  end

	def configure_permitted_parameters
    permitted_params = [:nombre, :apellido, :email, :'fecha_de_nacimiento(1i)',
      :'fecha_de_nacimiento(2i)', :'fecha_de_nacimiento(3i)', :dni, :calle, :role_ids,
      :ciudad, :codigo_postal, :tel1, :cel1, :type,  :password, :password_confirmation,
                        :current_password,:terminos, :email_invitado_1,
                        :email_invitado_2, :email_invitado_3, :email_invitado_4, role_ids:[],
                        circulo_attributes:[:coordinador_id, :warehouse_id]]
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(permitted_params) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(permitted_params) }
  end

  def authenticate
    authenticate_token || render_unauthorized
  end

  def authenticate_token
    Usuario.find_by(confirmation_token: params[:token]).present?
  end

  def render_unauthorized
    self.headers['WWW-Authenticate'] = 'Token realm="Application"'
    render json: 'Bad credentials', status: 401
  end

  private

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  def render_404(exception = nil)
    if exception
      logger.info "Rendering 404: #{exception.message}"
    end

    render :file => "#{Rails.root}/public/404.html", :status =>404, :layout => false
  end

end
