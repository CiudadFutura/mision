class Api::V1::UsuariosController < ApplicationController
  before_action :authenticate

  def index
    @users = Usuario.all
  end

end