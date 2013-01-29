$:.push File.expand_path("../lib", __FILE__)
require "devise/stormpath/version"

Gem::Specification.new do |s|
  s.name     = 'devise-stormpath'
  s.version  = Devise::Stormpath::VERSION
  s.platform = Gem::Platform::RUBY
  s.summary  = 'Devise extension to allow authentication via Stormpath'
  s.email = 'liquidautumn@gmail.com'
  s.homepage      = "http://www.stormpath.com"
  s.description = s.summary
  s.author = 'Denis Grankin'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency('devise')
  s.add_dependency('stormpath-rails', '~> 0.4.0')
  s.add_dependency('activesupport')

  s.add_development_dependency('rake', '~> 10.0.2')
  s.add_development_dependency('rspec', '~> 2.12.0')
  s.add_development_dependency('guard-rspec', '~> 2.2.1')
  s.add_development_dependency('rb-inotify', '~> 0.8.8')
end
