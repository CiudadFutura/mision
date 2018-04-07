class RemitosController < ApplicationController
  def index
  end

  def show
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "remitopedido"   # Excluding ".pdf" extension.
      end
    end
  end
end
