require "rails_helper"

RSpec.describe CategoriasController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/categorias").to route_to("categorias#index")
    end

    it "routes to #new" do
      expect(:get => "/categorias/new").to route_to("categorias#new")
    end

    it "routes to #show" do
      expect(:get => "/categorias/1").to route_to("categorias#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/categorias/1/edit").to route_to("categorias#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/categorias").to route_to("categorias#create")
    end

    it "routes to #update" do
      expect(:put => "/categorias/1").to route_to("categorias#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/categorias/1").to route_to("categorias#destroy", :id => "1")
    end

  end
end
