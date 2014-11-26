require 'rails_helper'

RSpec.describe "Circulos", :type => :request do
  describe "GET /circulos" do
    it "works! (now write some real specs)" do
      get circulos_path
      expect(response.status).to be(200)
    end
  end
end
