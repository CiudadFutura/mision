class Api::V1::SuppliersController < ApplicationController
  before_action :authenticate

  def index
    @suppliers = Supplier.all
  end

end