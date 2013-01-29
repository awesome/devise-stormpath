Devise Stormpath authentication
===========================

Usage
-----
In the Gemfile for your application:

    gem "devise-stormpath"

In devise model:

    devise :stormpath_authenticatable

Password reset
--------------

Model:

    devise :stormpath_authenticatable, :stormpath_recoverable

Setup Password Reset Workflow at https://api.stormpath.com
Set Base URL to //<app host>/<devise scope>/password/edit (i.e. https://example.com/users/password/edit)
