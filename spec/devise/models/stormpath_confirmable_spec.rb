require "spec_helper"
require "devise/models/stormpath_confirmable"

describe Devise::Models::StormpathConfirmable do
  class User
    def self.attr_accessible(*args)
    end

    include Devise::Models::StormpathConfirmable
  end

  let(:base) { mock("base") }
  let(:errors) { mock("errors", :[] => base) }
  let(:user) { mock("user", errors: errors) }

  describe "::confirm_by_token" do
    let(:account) { mock("account", get_href: "user href") }

    it "should verify confirmation token at Stormpath and return user if verification passed" do
      Stormpath::Rails::Client.should_receive(:verify_account_email).with("token").and_return(account)
      User.should_receive(:where).with(stormpath_url: "user href").and_return([user])
      User.confirm_by_token("token").should == user
    end
  end
end
