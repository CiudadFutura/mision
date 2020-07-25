class User::SessionsController < Devise::SessionsController
  prepend_before_action :check_captcha, only: [:create] # Change this to be any actions you want to protect.

  prepend_view_path 'app/views/devise'

  private
  def check_captcha
    unless verify_recaptcha
      self.resource = resource_class.new sign_in_params
      sign_out(self.resource)
      redirect_to '/usuarios/sign_in'
    end
  end
end