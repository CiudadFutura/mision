class Api::V1::CustomersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index

    if params[:token].present? and params[:token] == Rails.application.secrets.secret_mai_token
      @customers = Usuario.all.order(:id)
      render json: {status: 'SUCCESS', messagge: 'Cargados todos los usuarios', data: @customers}, status: :ok
    else
      render nothing: true, status: :unauthorized
    end

  end


end