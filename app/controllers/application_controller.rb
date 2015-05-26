class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :init_carrito
  before_filter :categorias_menu

  layout 'layout'

  def current_ability
    @current_ability ||= Ability.new(current_usuario)
  end

  def init_carrito
    @carrito = Cart.new(session)
  end

  def categorias_menu
    @categorias_menu = Rails.cache.fetch("categorias_menu") do 
      Categoria.where(parent_id: 'NULL')
    end
  end

  private
  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end
