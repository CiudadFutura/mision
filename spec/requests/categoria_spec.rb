require 'rails_helper'

RSpec.describe "Categorias", :type => :request do
  describe "GET /categorias" do
    it "works! (now write some real specs)" do
      get categorias_path
      expect(response.status).to be(200)
    end
  end
end
