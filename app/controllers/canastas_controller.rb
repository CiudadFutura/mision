class CanastasController < ApplicationController
  before_action :set_canasta, only: [:show, :edit, :update, :destroy]
  authorize_resource

  # GET /canastas
  # GET /canastas.json
  def index
    @canastas = Canasta.all
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_canasta
    @canasta = Compra.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def producto_params
    params.require(:canasta).permit(:description)
  end

end