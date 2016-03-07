require 'rails_helper'

RSpec.describe RemitosPedidoController, :type => :controller do

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to be_success
    end
  end

  describe "GET generate" do
    it "returns http success" do
      get :generate
      expect(response).to be_success
    end
  end

end
