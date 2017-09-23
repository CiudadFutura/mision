class Api::V1::SuppliersController < ApplicationController
  before_action :authenticate

  def index
    if params.has_key?(:suppliers_date)
      @suppliers = Supplier.evo_suppliers(DateTime.parse(params[:suppliers_date], '%d/%m/%y'))
    else
      @suppliers = Supplier.all
    end
  end

end