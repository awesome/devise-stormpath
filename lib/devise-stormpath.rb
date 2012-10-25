require 'devise'

Devise.add_module(:stormpath_authenticatable,
                  :route => :session, :strategy   => true, :controller => :sessions, :model  => 'devise/stormpath/model')
