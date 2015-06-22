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

  private
  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end
