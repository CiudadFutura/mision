class Api::V1::ProductsController < ApplicationController
  before_action :authenticate

  def index
    @products = Producto.all
  end

end