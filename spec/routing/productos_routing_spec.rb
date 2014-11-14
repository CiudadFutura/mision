require "rails_helper"

RSpec.describe ProductosController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/productos").to route_to("productos#index")
    end

    it "routes to #new" do
      expect(:get => "/productos/new").to route_to("productos#new")
    end

    it "routes to #show" do
      expect(:get => "/productos/1").to route_to("productos#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/productos/1/edit").to route_to("productos#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/productos").to route_to("productos#create")
    end

    it "routes to #update" do
      expect(:put => "/productos/1").to route_to("productos#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/productos/1").to route_to("productos#destroy", :id => "1")
    end

  end
end
