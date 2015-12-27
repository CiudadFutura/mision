class GeoReportController < ApplicationController

  # GET /usuarios
  # GET /usuarios.json
  def index
    @usuarios = Usuario.where(['type != "Admin"'])
  end
end
