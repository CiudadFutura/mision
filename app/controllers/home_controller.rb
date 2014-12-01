class HomeController < ActionController::Base
  #home.html.erb exists

  def index
    render "layouts/home"
  end

end
