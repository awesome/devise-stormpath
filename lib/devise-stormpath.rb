require 'devise'
require 'stormpath-rails'

require 'devise/stormpath/strategy'

Warden::Strategies.add(:stormpath_authenticatable, Devise::Strategies::StormpathAuthenticatable)

Devise.add_module(:stormpath_authenticatable,
                  :route => :session, :strategy => true, :controller => :sessions, :model  => 'devise/stormpath/model')
