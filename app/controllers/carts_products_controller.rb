class CartsProductsController < ApplicationController
	before_action :set_carts_products, only: [:show, :edit, :update, :destroy]


	# GET /carts_products
	# GET /carts_products.json
	def index
		@carts_products = CartProduct.all
	end

	# GET /carts_products/1
	# GET /carts_products/1.json
	def show
	end

	# GET /carts_products/new
	def new
		@carts_products = CartProduct.new
	end

	# GET /carts_products/1/edit
	def edit
	end

	# POST /carts_products
	# POST /carts_products.json
	def create
		@carts_products = CartProduct.new(carts_products_params)

		respond_to do |format|
			if @carts_products.save
				format.html { redirect_to @carts_products, notice: 'Cart Product was successfully created.' }
				format.json { render :show, status: :created, location: @carts_products }
			else
				format.html { render :new }
				format.json { render json: @carts_products.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /carts_products/1
	# PATCH/PUT /carts_products/1.json
	def update
		@carts_products = CartProduct.find(params[:id])
		respond_to do |format|
			if @carts_products.update(checkpoint: params[:checkpoint] )
				format.html { redirect_to @carts_products, notice: 'Cart Product was successfully updated.' }
				format.json { render :show, status: :ok, location: @carts_products }
			else
				format.html { render :edit }
				format.json { render json: @carts_products.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /carts_products/1
	# DELETE /carts_products/1.json
	def destroy
		@carts_products.destroy(@cart.id)
		respond_to do |format|
			format.html { redirect_to carts_products_url, notice: 'Cart Product was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_carts_products
		@carts_products = CartProduct.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def carts_products_params
		params.fetch(:carts_products, {})
	end
end
