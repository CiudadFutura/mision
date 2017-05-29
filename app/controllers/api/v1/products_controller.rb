class Api::V1::ProductsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index

    if params[:token].present? and params[:token] == Rails.application.secrets.secret_mai_token
      @products = Producto.all.order(:orden, :nombre)
      render json: {status: 'SUCCESS', messagge: 'Cargados todos los productos', data: @products}, status: :ok
    else
      render nothing: true, status: :unauthorized
    end

  end


end