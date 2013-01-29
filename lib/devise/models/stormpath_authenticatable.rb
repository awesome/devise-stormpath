require "active_support/concern"

module Devise
  module Models
    module StormpathAuthenticatable
      extend ActiveSupport::Concern

      def self.required_fields(klass)
        [:current_password, :password, :password_confirmation]
      end

      included do
        attr_accessor :password_confirmation, :password
        attr_reader :current_password
      end

      module ClassMethods
        #TODO support login with email
        def authenticate_with_stormpath(attributes={})
          begin
            account = ::Stormpath::Rails::Client.authenticate_account(attributes[:username], attributes[:password])
            return self.where(stormpath_url: account.get_href).first
          rescue ResourceError => error
            return nil
          end
        end
      end
    end
  end
end
