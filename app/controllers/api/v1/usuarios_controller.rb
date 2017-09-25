class Api::V1::UsuariosController < ApplicationController
  before_action :authenticate

  def index
    if params.has_key?(:usuarios_date)
      @users = Usuario.evo_usuarios(DateTime.parse(params[:usuarios_date], '%d/%m/%y'))
    else
      @users = Usuario.all
    end
  end

end