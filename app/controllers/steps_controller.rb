class StepsController < ApplicationController
  layout "home"

  def index
    render 'devise/steps/steps'
  end
end