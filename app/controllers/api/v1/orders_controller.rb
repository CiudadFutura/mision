class Api::V1::OrdersController < ApplicationController
  before_action :authenticate

  def index
    if params.has_key?(:orders_date)
      @orders = Pedido.evo_orders(DateTime.parse(params[:orders_date], '%d/%m/%y'))
    else
      @orders = Pedido.all
    end
  end

end