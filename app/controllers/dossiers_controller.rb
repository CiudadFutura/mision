class DossiersController < ApplicationController
  layout "home"

  def index
    render 'devise/dossier/dossier'
  end
end