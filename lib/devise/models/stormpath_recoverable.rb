module Devise
  module Models
    module StormpathRecoverable
      extend ActiveSupport::Concern

      def self.required_fields(klass)
        [:reset_password_token, :password, :password_confirmation]
      end

      included do
        attr_accessible :reset_password_token, :password_confirmation
        attr_accessor :reset_password_token
      end

      protected

      def after_password_reset
      end

      module ClassMethods
        def send_reset_password_instructions(attributes={})
          begin
            identifier = attributes[:email] || attributes[:username]
            raise RuntimeError.new "Email or username required" unless identifier
            account = ::Stormpath::Rails::Client.send_password_reset_email(identifier)
            return self.where(stormpath_url: account.get_href).first
          rescue RuntimeError => error
            build_invalid_account(attributes, error)
          end
        end

        def reset_password_by_token(attributes={})
          begin
            validate_attributes(attributes)
            account = ::Stormpath::Rails::Client.verify_password_reset_token(attributes[:reset_password_token])
            account.set_password attributes[:password]
            account.save
            self.where(stormpath_url: account.get_href).first
          rescue RuntimeError => error
            build_invalid_account(attributes, error)
          end
        end

        def build_invalid_account(attributes, error)
          u = self.new(attributes)
          u.errors[:base] << error.message
          u
        end

        #TODO work on better error handling and move strings to locales
        def validate_attributes(attributes)
          raise RuntimeError.new "Password reset token required" unless attributes[:reset_password_token]
          raise RuntimeError.new "Password should match confirmation" unless attributes[:password] == attributes[:password_confirmation]
          raise RuntimeError.new "Password required" unless attributes[:password] && !attributes[:password].empty?
        end
      end
    end
  end

  #mimic default devise recoverable
  class Mapping
    def recoverable?
      @recoverable ||= self.modules.any? { |m| m.to_s =~ /recoverable/ }
    end
  end
end
