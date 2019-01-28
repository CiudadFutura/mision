class Api::V1::TransactionsController < ApplicationController
  before_action :authenticate

  def index
    if params.has_key?(:transaction_date)
      @transactions = Transaction.evo_transactions(DateTime.parse(params[:transaction_date], '%d/%m/%y'))
    else
      @transactions = Transaction.evo_transactions
    end

  end

end