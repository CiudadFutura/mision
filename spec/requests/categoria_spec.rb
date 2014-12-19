require 'rails_helper'

RSpec.describe "Categoria", :type => :request do
  describe "GET /categoria" do
    it "works! (now write some real specs)" do
      get categoria_path
      expect(response.status).to be(200)
    end
  end
end
