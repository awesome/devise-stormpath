require 'stormpath-rails'

require 'devise'
require 'devise/stormpath/routes'
require 'devise/stormpath/rails'
require 'devise/strategies/stormpath_authenticatable'

Warden::Strategies.add(:stormpath_authenticatable, Devise::Strategies::StormpathAuthenticatable)

Devise.add_module(:stormpath_authenticatable, :route => :session, :strategy => true, :controller => :sessions, :model  => 'devise/models/stormpath_authenticatable')
Devise.add_module(:stormpath_recoverable, :route => :password, :controller => :stormpath_passwords, :model  => 'devise/models/stormpath_recoverable')
Devise.add_module(:stormpath_confirmable, :route => :confirmation, :controller => :stormpath_confirmations, :model  => 'devise/models/stormpath_confirmable')
