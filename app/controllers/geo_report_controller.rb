class GeoReportController < ApplicationController

  # GET /usuarios
  # GET /usuarios.json
  def index
    @usuarios = Usuario.where(['type <> "Admin" AND calle IS NOT NULL AND calle <> "" '])
  end
end
