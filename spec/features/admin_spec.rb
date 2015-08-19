require 'rails_helper'

describe 'user management by admin' do
  before :each do
    admin = FactoryGirl.create(:admin)
    sign_in admin
  end

  it "adds a common user" do
    click_link 'Usuarios'
    expect(current_path).to eq usuarios_path

    click_link 'Crear'
    expect(current_path).to eq new_usuario_path

    expect {
      fill_in 'usuario_nombre', with: 'Nombre_Usuario'
      fill_in 'usuario_apellido', with: 'Apellido_Usuario'
      fill_in 'usuario_email', with: 'test@example.com'
      fill_in 'usuario_password', with: '!QAZzaq1'
      fill_in 'usuario_password_confirmation', with: '!QAZzaq1'
      select 'Usuario', from: 'usuario_type'
      click_button 'Crear'
    }.to change(Usuario, :count).by(1)

    expect(page).to have_content 'Nombre_Usuario'
    expect(page).to have_content 'Usuario'
  end

  it "adds a coordinador user" do
    click_link 'Usuarios'
    expect(current_path).to eq usuarios_path

    click_link 'Crear'
    expect(current_path).to eq new_usuario_path

    expect {
      fill_in 'usuario_nombre', with: 'Nombre_Coordinador'
      fill_in 'usuario_apellido', with: 'Apelido_Coodinador'
      fill_in 'usuario_email', with: 'test@example.com'
      fill_in 'usuario_password', with: '!QAZzaq1'
      fill_in 'usuario_password_confirmation', with: '!QAZzaq1'
      select 'Coordinador', from: 'usuario_type'
      click_button 'Crear'
    }.to change(Usuario, :count).by(1)

    expect(page).to have_content 'Nombre_Coordinador'
    expect(page).to have_content 'Coordinador'
  end

  it "can't assign common user as circulo coordinador" do
    user = FactoryGirl.create(:user)

    click_link 'Circulos'
    expect(current_path).to eq circulos_path

    click_link 'Crear'
    expect(current_path).to eq new_circulo_path

    expect {
      fill_in 'circulo_coordinador_id', with: user.id
      click_button 'Crear'
    }.not_to change(Circulo, :count)

    expect(page).to have_content "El usuario no es un coordinador."
  end

  it "assign coordinador to circulo" do
    user = FactoryGirl.create(:coordinador)

    click_link 'Circulos'
    expect(current_path).to eq circulos_path

    click_link 'Crear'
    expect(current_path).to eq new_circulo_path

    expect {
      fill_in 'circulo_coordinador_id', with: user.id
      click_button 'Crear'
    }.to change(Circulo, :count).by(1)

    expect(page).to have_content user.nombre
  end

end