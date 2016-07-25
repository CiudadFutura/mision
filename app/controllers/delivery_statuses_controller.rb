class DeliveryStatusesController < ApplicationController
  before_action :set_delivery_status, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @delivery_statuses = DeliveryStatus.all
    respond_with(@delivery_statuses)
  end

  def show
    respond_with(@delivery_status)
  end

  def new
    @delivery_status = DeliveryStatus.new
    respond_with(@delivery_status)
  end

  def edit
  end

  def create
    @delivery_status = DeliveryStatus.new(delivery_status_params)
    @delivery_status.save
    respond_with(@delivery_status)
  end

  def update
    @delivery_status.update(delivery_status_params)
    respond_with(@delivery_status)
  end

  def destroy
    @delivery_status.destroy
    respond_with(@delivery_status)
  end

  private
    def set_delivery_status
      @delivery_status = DeliveryStatus.find(params[:id])
    end

    def delivery_status_params
      params[:delivery_status]
    end
end
