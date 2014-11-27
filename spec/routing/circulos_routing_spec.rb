require "rails_helper"

RSpec.describe CirculosController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/circulos").to route_to("circulos#index")
    end

    it "routes to #new" do
      expect(:get => "/circulos/new").to route_to("circulos#new")
    end

    it "routes to #show" do
      expect(:get => "/circulos/1").to route_to("circulos#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/circulos/1/edit").to route_to("circulos#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/circulos").to route_to("circulos#create")
    end

    it "routes to #update" do
      expect(:put => "/circulos/1").to route_to("circulos#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/circulos/1").to route_to("circulos#destroy", :id => "1")
    end

  end
end
