class Devise::StormpathPasswordsController < Devise::PasswordsController
  prepend_before_filter :proxy_stormpath_token

  protected

  def proxy_stormpath_token
    params[:reset_password_token] = params[:sptoken]
  end
end
