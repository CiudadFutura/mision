class ComoComproController < ApplicationController
  layout "home"

  def index
    render 'devise/como_compro/como_compro'
  end

  def show
    render 'devise/como_compro/como_compro'
  end
end