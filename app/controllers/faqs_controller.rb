class FaqsController < ApplicationController
  layout "home"

  def index
    render 'devise/faq/faq'
  end
end