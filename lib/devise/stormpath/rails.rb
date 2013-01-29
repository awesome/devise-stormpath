module Devise
  module Stormpath
    class Engine < Rails::Engine
      initializer "stormpath.params.filter" do |app|
        app.config.filter_parameters << :sptoken
      end
    end
  end
end
