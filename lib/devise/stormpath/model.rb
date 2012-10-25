require 'devise/stormpath/strategy'
require 'stormpath-rails'

module Devise
  module Models
    module StormpathAuthenticatable
      extend ActiveSupport::Concern

      included do
        attr_accessor :password_confirmation, :password
        attr_reader :current_password
      end

      module ClassMethods
        def authenticate_with_stormpath(attributes={})
          login = (self.case_insensitive_keys || []).include?(:username) ? attributes[:username].downcase : attributes[:username]
          begin
            account = ::Stormpath::Rails::Client.authenticate_account(login, attributes[:password])
            return self.where(stormpath_url: account.get_href).first
          rescue ResourceError => error
            return nil
          end
        end
      end
    end
  end
end
