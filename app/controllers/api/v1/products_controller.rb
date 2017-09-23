class Api::V1::ProductsController < ApplicationController
  before_action :authenticate

  def index
    if params.has_key?(:products_date)
      @products = Producto.evo_products(DateTime.parse(params[:products_date], '%d/%m/%y'))
    else
      @products = Producto.all
    end
  end

end