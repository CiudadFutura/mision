class TransactionDetailsController < ApplicationController
  before_action :set_transaction_detail, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @transaction_details = TransactionDetail.all
    respond_with(@transaction_details)
  end

  def show
    respond_with(@transaction_detail)
  end

  def new
    @transaction_detail = TransactionDetail.new
    respond_with(@transaction_detail)
  end

  def edit
  end

  def create
    @transaction_detail = TransactionDetail.new(transaction_detail_params)
    @transaction_detail.save
    respond_with(@transaction_detail)
  end

  def update
    @transaction_detail.update(transaction_detail_params)
    respond_with(@transaction_detail)
  end

  def destroy
    @transaction_detail.destroy
    respond_with(@transaction_detail)
  end

  private
    def set_transaction_detail
      @transaction_detail = TransactionDetail.find(params[:id])
    end

    def transaction_detail_params
      params.require(:transaction_detail).permit(:transaction_id, :producto_id, :price, :quantity, :subtotal)
    end
end
