require 'rails_helper'

RSpec.describe "TransactionDetails", :type => :request do
  describe "GET /transaction_details" do
    it "works! (now write some real specs)" do
      get transaction_details_path
      expect(response.status).to be(200)
    end
  end
end
