module Devise
  module Models
    module StormpathConfirmable
      extend ActiveSupport::Concern

      def self.required_fields(klass)
        [:confirmation_token]
      end

      included do
        attr_accessible :confirmation_token
        attr_accessor :confirmation_token
      end

      def confirmed?
        status != "UNVERIFIED"
      end

      def active_for_authentication?
        super && confirmed?
      end

      def inactive_message
        !confirmed? ? :unconfirmed : super
      end

      protected

      module ClassMethods
        def confirm_by_token(token)
          begin
            raise RuntimeError.new "Verification token required" unless token
            account = ::Stormpath::Rails::Client.verify_account_email(token)
            return self.where(stormpath_url: account.get_href).first
          rescue RuntimeError => error
            u = self.new
            u.errors[:base] << error.message
            u
          end
        end
      end
    end
  end
end
