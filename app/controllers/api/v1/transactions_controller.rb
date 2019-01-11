class Api::V1::TransactionsController < ApplicationController
  before_action :authenticate

  def index
    if params.has_key?(:orders_date)
      @transactions = Transaction.evo_transactions(DateTime.parse(params[:orders_date], '%d/%m/%y'))
    else
      @transactions = Transaction.all
    end

  end

end