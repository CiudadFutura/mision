require "rails_helper"

RSpec.describe DeliveryStatusesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/delivery_statuses").to route_to("delivery_statuses#index")
    end

    it "routes to #new" do
      expect(:get => "/delivery_statuses/new").to route_to("delivery_statuses#new")
    end

    it "routes to #show" do
      expect(:get => "/delivery_statuses/1").to route_to("delivery_statuses#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/delivery_statuses/1/edit").to route_to("delivery_statuses#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/delivery_statuses").to route_to("delivery_statuses#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/delivery_statuses/1").to route_to("delivery_statuses#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/delivery_statuses/1").to route_to("delivery_statuses#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/delivery_statuses/1").to route_to("delivery_statuses#destroy", :id => "1")
    end

  end
end
