class CartsController < ApplicationController
  # Habilitar cuando se instale devise
  # before_action :authenticate_user!

  def show
    @carrito = Producto.find(session[:product_ids])
  end

  def add
    session[:product_ids] << params[:producto_id]
    render json: session[:product_ids].count, status: 200
  end

  def remove
    session[:product_ids].delete(params[:producto_id])
    render json: session[:product_ids].count, status: 200
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def cart_params
    params.permit(:producto_id)
  end
end
