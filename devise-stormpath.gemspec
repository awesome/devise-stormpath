$:.push File.expand_path("../lib", __FILE__)
require "devise/stormpath/version"

Gem::Specification.new do |s|
  s.name     = 'devise-stormpath'
  s.version  = Devise::Stormpath::VERSION
  s.platform = Gem::Platform::RUBY
  s.summary  = 'Devise extension to allow authentication via Stormpath'
  s.email = 'liquidautumn@gmail.com'
  s.homepage = 'https://github.com/liquidautumn/devise-stormpath'
  s.description = s.summary
  s.author = 'Denis Grankin'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency('devise')
  s.add_dependency('stormpath-rails')

  s.add_development_dependency('rake')
end
