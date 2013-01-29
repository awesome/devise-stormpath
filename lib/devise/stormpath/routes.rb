ActionDispatch::Routing::Mapper.class_eval do
  protected

  def devise_password(mapping, controllers)
    resource :password, :only => [:new, :create, :edit, :update],
             :path => mapping.path_names[:password], :controller => controllers[:stormpath_passwords]
  end
end