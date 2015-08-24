require 'rails_helper'

RSpec.describe "A Usuario", :type => :request do

  it "can sign in as common user" do
    visit root_path
    click_link 'Iniciar Sesion'
    expect(current_path).to eq usuario_session_path
    click_link 'Registrate'
    expect(current_path).to eq new_usuario_registration_path

    expect {
      fill_in 'usuario_nombre', with: 'Nombre_Usuario'
      fill_in 'usuario_apellido', with: 'Apellido_Usuario'
      fill_in 'usuario_email', with: 'test@example.com'
      fill_in 'usuario_password', with: '!QAZzaq1'
      fill_in 'usuario_password_confirmation', with: '!QAZzaq1'
      choose 'Usuario'

      click_button 'Registrate'
    }.to change(Usuario, :count).by(1)
  end

  it "can sign in as coordinador user" do
    visit root_path
    click_link 'Iniciar Sesion'
    expect(current_path).to eq usuario_session_path
    click_link 'Registrate'
    expect(current_path).to eq new_usuario_registration_path

    expect {
      fill_in 'usuario_nombre', with: 'Nombre_Coordinador'
      fill_in 'usuario_apellido', with: 'Apellido_Coordinador'
      fill_in 'usuario_email', with: 'test@example.com'
      fill_in 'usuario_password', with: '!QAZzaq1'
      fill_in 'usuario_password_confirmation', with: '!QAZzaq1'
      choose 'Coordinador'

      click_button 'Registrate'
    }.to change(Usuario, :count).by(1)
  end

end
