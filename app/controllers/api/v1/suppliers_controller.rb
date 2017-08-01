class Api::V1::SuppliersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index

    if params[:token].present? and params[:token] == Rails.application.secrets.secret_mai_token
      @suppliers = Supplier.all.order(:name)
      render json: {status: 'SUCCESS', messagge: 'Cargados todos los proveedores', data: @suppliers}, status: :ok
    else
      render nothing: true, status: :unauthorized
    end

  end


end