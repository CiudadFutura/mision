require 'rails_helper'

RSpec.describe "Compras", :type => :request do
  describe "GET /compras" do
    it "works! (now write some real specs)" do
      get compras_path
      expect(response.status).to be(200)
    end
  end
end
