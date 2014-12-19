require "rails_helper"

RSpec.describe CategoriaController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/categoria").to route_to("categoria#index")
    end

    it "routes to #new" do
      expect(:get => "/categoria/new").to route_to("categoria#new")
    end

    it "routes to #show" do
      expect(:get => "/categoria/1").to route_to("categoria#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/categoria/1/edit").to route_to("categoria#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/categoria").to route_to("categoria#create")
    end

    it "routes to #update" do
      expect(:put => "/categoria/1").to route_to("categoria#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/categoria/1").to route_to("categoria#destroy", :id => "1")
    end

  end
end
