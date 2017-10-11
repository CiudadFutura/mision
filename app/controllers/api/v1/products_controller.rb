class Api::V1::ProductsController < ApplicationController
  before_action :set_usuario, :authenticate, only: [:index]
  before_action :set_product, only: [:update]
  protect_from_forgery with: :null_session, only: Proc.new { |c| c.request.format.json? }


  def index
    if params.has_key?(:products_date)
      @products = Producto.evo_products(DateTime.parse(params[:products_date], '%d/%m/%y'))
    else
      @products = Producto.all
    end
  end

  def update
    if @product.update(stock: params[:stock])
      render json: @product, status: :ok
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  private
    def set_product
      @product = Producto.find(params[:id])
    end

    def set_usuario
      @usuario = Usuario.find_by(confirmation_token: request.params[:token])
    end

end
