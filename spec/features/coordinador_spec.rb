require 'rails_helper'

RSpec.describe "A Coordinador", :type => :request do
  before do
  end

  it 'can invite 5 user to be part of the site' do
    visit root_path
    click_link 'Iniciar Sesion'
    expect(current_path).to eq usuario_session_path
    click_link 'Registrate'
    expect(current_path).to eq new_usuario_registration_path


    fill_in 'usuario_nombre', with: 'Nombre_Coordinador'
    fill_in 'usuario_apellido', with: 'Apellido_Coordinador'
    fill_in 'usuario_email', with: 'test@example.com'
    fill_in 'usuario_password', with: '!QAZzaq1'
    fill_in 'usuario_password_confirmation', with: '!QAZzaq1'
    choose 'Coordinador'

    fill_in 'email_invitado_1', with: 'invitado_1@example.com'
    fill_in 'email_invitado_2', with: 'invitado_2@example.com'
    fill_in 'email_invitado_3', with: 'invitado_3@example.com'
    fill_in 'email_invitado_4', with: 'invitado_4@example.com'

    expect {
      click_button 'Registrate'
    }.to change { ActionMailer::Base.deliveries.count }.by(5)
  end
end