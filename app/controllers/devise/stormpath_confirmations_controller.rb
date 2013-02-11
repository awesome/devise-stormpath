class Devise::StormpathConfirmationsController < Devise::ConfirmationsController
  prepend_before_filter :proxy_stormpath_token

  protected

  def proxy_stormpath_token
    params[:confirmation_token] = params[:sptoken]
  end
end
