require 'rails_helper'

RSpec.describe "DeliveryStatuses", type: :request do
  describe "GET /delivery_statuses" do
    it "works! (now write some real specs)" do
      get delivery_statuses_path
      expect(response).to have_http_status(200)
    end
  end
end
