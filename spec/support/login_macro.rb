namespace :login_macro do
  def sign_in(user)
    visit root_path
    click_link 'Iniciar Sesion'
    fill_in 'usuario_email', with: user.email
    fill_in 'usuario_password', with: user.password
    click_button 'Ingresar'
  end
end