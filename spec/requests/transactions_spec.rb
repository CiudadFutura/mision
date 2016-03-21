require 'rails_helper'

RSpec.describe "Transactions", :type => :request do
  describe "GET /transactions" do
    it "works! (now write some real specs)" do
      get transactions_path
      expect(response.status).to be(200)
    end
  end
end
