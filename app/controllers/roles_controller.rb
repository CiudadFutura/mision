class RolesController < ApplicationController
  before_action :set_role, only: [:show, :edit, :update, :destroy]
  authorize_resource

  # GET /roles
  # GET /roles.json
  def index
    @roles = Role.all
  end

  # GET /role/new
  def new
    @role = Role.new
  end

  # GET /role/1
  # GET /role/1.json
  def show
  end

  # GET /role/new
  def new
    @role = Role.new
  end

  # GET /role/1/edit
  def edit
  end

  # POST /role
  # POST /role.json
  def create
    @role = Role.new(role_params)

    respond_to do |format|
      if @role.save
        format.html { redirect_to @role, notice: 'Rol de Usuario creado exitosamente.' }
        format.json { render :show, status: :created, location: @role }
      else
        format.html { render :new }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /role/1
  # PATCH/PUT /role/1.json
  def update
    respond_to do |format|
      if @role.update(role_params)
        format.html { redirect_to @role, notice: 'Rol de Usuario editado exitosamente' }
        format.json { render :show, status: :ok, location: @role }
      else
        format.html { render :edit }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /role/1
  # DELETE /role/1.json
  def destroy
    @role.destroy
    respond_to do |format|
      format.html { redirect_to role_url, notice: 'Rol de Usuario eliminado exitosamente' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_role
    @role = Role.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def role_params
    params.require(:role).permit(:name)
  end
end