require 'devise/strategies/authenticatable'

module Devise
  module Strategies
    class StormpathAuthenticatable < Authenticatable
      def authenticate!
        resource = valid_password? && mapping.to.authenticate_with_stormpath(params[scope])
        return success!(resource) if resource && validate(resource)
        fail(:invalid)
      end
    end
  end
end
