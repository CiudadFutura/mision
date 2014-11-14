require 'rails_helper'

RSpec.describe "Productos", :type => :request do
  describe "GET /productos" do
    it "works! (now write some real specs)" do
      get productos_path
      expect(response.status).to be(200)
    end
  end
end
