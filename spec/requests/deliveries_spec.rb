require 'rails_helper'

RSpec.describe "Deliveries", type: :request do
  describe "GET /deliveries" do
    it "works! (now write some real specs)" do
      get deliveries_path
      expect(response).to have_http_status(200)
    end
  end
end
