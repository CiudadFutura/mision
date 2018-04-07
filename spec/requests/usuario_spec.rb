require 'rails_helper'

RSpec.describe Api::V1::UsuariosController, type: :request do

  describe 'GET /usuarios' do
    before :each do
      FactoryBot.create_list(:usuarios, 1)
      get '/api/v1/usuarios'
    end

    it { have_http_status(200) }
    it 'mostrar todos los usuarios' do
      json = JSON.parse(response.body)
      expect(json.length).to eq(Usuario.count)
    end
  end

end