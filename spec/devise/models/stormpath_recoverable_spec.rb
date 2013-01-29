require "spec_helper"
require "devise/models/stormpath_recoverable"

describe Devise::Models::StormpathRecoverable do
  class User
    def self.attr_accessible(*args)
    end

    include Devise::Models::StormpathRecoverable
  end

  let(:base) { mock("base") }
  let(:errors) { mock("errors", :[] => base) }
  let(:user) { mock("user", errors: errors) }

  describe "::send_reset_password_instructions" do
    it "should return user if password reset email sent and local user exists with returned href" do
      Stormpath::Rails::Client.should_receive(:send_password_reset_email).with("john@example.com").and_return(mock("account", get_href: "user href"))
      User.should_receive(:where).with(stormpath_url: "user href").and_return([user])
      User.send_reset_password_instructions(email: "john@example.com").should == user
    end

    it "should return errored user instance if no email provided" do
      Stormpath::Rails::Client.should_receive(:send_password_reset_email).and_raise(ResourceError.new("Error"))
      User.stub(:new).and_return(user)
      base.should_receive(:<<).with("Error")
      User.send_reset_password_instructions(email: "").should == user
    end
  end

  describe "::reset_password_by_token" do
    let(:account) { mock("account", get_href: "user href") }

    it "should update password at Stormpath and return user if password reset token is valid" do
      Stormpath::Rails::Client.should_receive(:verify_password_reset_token).with("token").and_return(account)
      account.should_receive(:set_password).with("password")
      account.should_receive(:save)
      User.should_receive(:where).with(stormpath_url: "user href").and_return([user])
      User.reset_password_by_token(reset_password_token: "token", password: "password", password_confirmation: "password").should == user
    end
  end
end
