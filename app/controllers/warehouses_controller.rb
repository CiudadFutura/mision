class WarehousesController < ApplicationController
	before_action :set_warehouse, only: [:show, :edit, :update, :destroy]
	authorize_resource

	# GET /warehouses
	# GET /warehouses.json
	def index
		@warehouses = Warehouse.all
	end

	# GET /warehouses/1
	# GET /warehouses/1.json
	def show
	end

	# GET /warehouses/new
	def new
		@warehouse = Warehouse.new
	end

	# GET /warehouses/1/edit
	def edit
	end

	# POST /warehouses
	# POST /warehouses.json
	def create
		@warehouse = Warehouse.new(warehouse_params)

		respond_to do |format|
			if @warehouse.save
				format.html { redirect_to @warehouse, notice: 'Depósito creado exitosamente.' }
				format.json { render :show, status: :created, location: @warehouse }
			else
				format.html { render :new }
				format.json { render json: @warehouse.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /warehouses/1
	# PATCH/PUT /warehouses/1.json
	def update
		respond_to do |format|
			if @warehouse.update(warehouse_params)
				format.html { redirect_to @warehouse, notice: 'Depósito modificado exitosamente..' }
				format.json { render :show, status: :ok, location: @warehouse }
			else
				format.html { render :edit }
				format.json { render json: @warehouse.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /warehouses/1
	# DELETE /warehouses/1.json
	def destroy
		@warehouse.destroy
		respond_to do |format|
			format.html { redirect_to warehouses_url, notice: 'Depósito eliminado exitosamente.' }
			format.json { head :no_content }
		end
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_warehouse
		@warehouse = Warehouse.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def warehouse_params
		params.require(:warehouse).permit(:name, :description, :address, :telephone, :working_hours, :attendant)
	end
end