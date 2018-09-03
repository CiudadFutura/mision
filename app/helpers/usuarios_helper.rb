module UsuariosHelper

  def user_data_completed(user)
    user.completed?
  end

end
