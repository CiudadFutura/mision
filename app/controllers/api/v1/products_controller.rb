class Api::V1::ProductsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index

    @products = Producto.all.order(:orden, :nombre)

    if  params[:token] != Rails.application.secrets.secret_mai_token
      render nothing: true, status: :unauthorized
    else
      render json: {status: 'SUCCESS', messagge: 'Cargados todos los productos', data: @products}, status: :ok
    end

  end


end