require 'rails_helper'

RSpec.describe "Sectors", type: :request do
  describe "GET /sectors" do
    it "works! (now write some real specs)" do
      get sectors_path
      expect(response).to have_http_status(200)
    end
  end
end
