[![Build Status](https://travis-ci.org/liquidautumn/devise-stormpath.png?branch=master)](https://travis-ci.org/liquidautumn/devise-stormpath)
[![Code Climate](https://codeclimate.com/github/liquidautumn/devise-stormpath.png)](https://codeclimate.com/github/liquidautumn/devise-stormpath)

# Stormpath authentication support for Devise

## Add gem reference to Gemfile
```ruby
gem "devise-stormpath"
```

## Setup stormpath-rails
Generate configuration file, then create directory per environment at stormpath and update stormpath.yml with corresponding directory hrefs.
```sh
rails g stormpath:rails:install
```

Generate and run migration, if you're on ActiveRecord. Skip this step for Mongoid.
```sh
rails g stormpath:rails:migration user
rake db:migrate
```
No need to include Stormpath::Rails::Account, it'll be done automatically.

## Configure Devise Modules

### Stormpath authentication
```ruby
devise :stormpath_authenticatable
```
Add user directory to application login sources, before trying to authenticate. Read more at https://www.stormpath.com/docs/console/product-guide#ManageLoginSources

### Registration
Default devise module works.
```ruby
devise :stormpath_authenticatable, :registerable
```

### Stormpath password reset
```ruby
devise :stormpath_authenticatable, :stormpath_recoverable
```
Setup Password Reset workflow (https://www.stormpath.com/docs/console/product-guide#PasswordReset)
Set Base URL to //{app host}/{devise scope}/password/edit (i.e. https://example.com/users/password/edit)

### Stormpath email verification
```ruby
devise :stormpath_authenticatable, :stormpath_confirmable
```
Setup Account Registration and Verification workflow (https://www.stormpath.com/docs/console/product-guide#AccountRegistration)
Set Base URL to //{app host}/{devise scope}/confirmation (i.e. https://example.com/users/confirmation)
