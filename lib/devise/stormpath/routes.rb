ActionDispatch::Routing::Mapper.class_eval do
  protected

  def devise_password(mapping, controllers)
    resource :password, :only => [:new, :create, :edit, :update],
             :path => mapping.path_names[:password], :controller => controllers[:stormpath_passwords]
  end

  def devise_confirmation(mapping, controllers)
    resource :confirmation, :only => [:show],
             :path => mapping.path_names[:confirmation], :controller => controllers[:stormpath_confirmations]
  end
end
