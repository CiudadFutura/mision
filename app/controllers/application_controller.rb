class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  rescue_from ActionController::RoutingError, :with => :render_404

  before_filter :init_carrito
  before_filter :categorias_menu
  before_filter :configure_permitted_parameters, if: :devise_controller?
  #before_filter :migrate

  layout 'layout'

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
    @categorias_menu = Rails.cache.fetch("categorias_menu") do
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

  def migrate
    if current_usuario.present? and current_usuario.email == 'nicofheredia@gmail.com'
      pedidos = Pedido.all
      pedidos.each do |pedido|
        #pedido.saving = pedido.ahorro
        total_amount = 0
        JSON.parse(pedido.items).map do |item|
          producto = Producto.find(item["producto_id"]) rescue nil
          if producto.present?
            supplier = Supplier.find(producto.supplier)
          end
          total_amount += item["total"].to_i

          pedido_details = pedido.pedidos_details.build(
            supplier_id: supplier.present? ? supplier.id : 'Sin Proveedor ID',
            supplier_name: supplier.present? ? supplier.name : 'Sin Proveedor Nombre',
            product_id: item["producto_id"],
            product_codigo: producto.present? ? producto.codigo : 'Sin Código',
            product_name: producto.present? ? producto.nombre : 'Sin Nombre',
            product_qty: item["cantidad"].to_i,
            product_price: (item["total"] / item["cantidad"]).to_f,
            total_line: (item["total"]).to_f

          )
          pedido.total = total_amount
          pedido.total_products = pedido.cantidad
          pedido_details.save
          total_amount = 0
        end
      end
    end
  end

  protected

	def configure_permitted_parameters
    permitted_params = [:nombre, :apellido, :email, :"fecha_de_nacimiento(1i)",
      :"fecha_de_nacimiento(2i)", :"fecha_de_nacimiento(3i)", :dni, :calle,
      :ciudad, :codigo_postal, :tel1, :cel1, :type,  :password, :password_confirmation,
      :terminos, :email_invitado_1, :email_invitado_2, :email_invitado_3, :email_invitado_4]
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(permitted_params) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(permitted_params) }
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
