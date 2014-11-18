class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :init_carrito

  layout "layout"

  def init_carrito
    session[:product_ids] = [] if session[:product_ids].nil?
  end
end
