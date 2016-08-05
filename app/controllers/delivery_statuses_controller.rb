class DeliveryStatusesController < ApplicationController
  before_action :set_delivery_status, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @delivery_statuses = DeliveryStatus.all
    respond_with(@delivery_statuses)
  end

  def show
    @deliveries = Delivery.where('compra_id = ? ', @delivery_status.delivery.compra.id)


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
    puts params.to_yaml
    @delivery_status = DeliveryStatus.find(params[:id])
    puts @delivery_status.to_yaml
    respond_to do |format|
      if @delivery_status.update(status_id: params[:status_id] )
        format.html { redirect_to @delivery_status, notice: 'Post was successfully updated.' }
        format.json { head :no_content } # 204 No Content
      else
        format.html { render action: "edit" }
        format.json { render json: @delivery_status.errors, status: :unprocessable_entity }
      end
    end
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

    def categoria_params
      params.require(:delivery_status).permit(:delivery_id, :sector_id, :status_id)
    end
end
