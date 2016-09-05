require "rails_helper"

RSpec.describe DeliveriesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/deliveries").to route_to("deliveries#index")
    end

    it "routes to #new" do
      expect(:get => "/deliveries/new").to route_to("deliveries#new")
    end

    it "routes to #show" do
      expect(:get => "/deliveries/1").to route_to("deliveries#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/deliveries/1/edit").to route_to("deliveries#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/deliveries").to route_to("deliveries#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/deliveries/1").to route_to("deliveries#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/deliveries/1").to route_to("deliveries#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/deliveries/1").to route_to("deliveries#destroy", :id => "1")
    end

  end
end
