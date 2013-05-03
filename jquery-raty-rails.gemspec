$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "jquery-raty-rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "jquery-raty-rails"
  s.version     = JqueryRatyRails::VERSION
  s.authors     = ["Brian M. Clapper"]
  s.email       = ["bmc@clapper.org"]
  s.homepage    = "https://github.com/bmc/jquery-raty-rails"
  s.summary     = "Integrate jquery-raty into Rails 3"
  s.description = "Integrates jquery-raty into the Rails 3 asset pipeline."

  s.files = Dir["{lib,vendor}/**/*"] + ["LICENSE.md", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 3.2.3"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "minitest"
  s.add_development_dependency "capybara"
  s.add_development_dependency "turn"
  #s.add_development_dependency "uglifier"
  s.add_development_dependency "gemcutter"
  s.add_development_dependency 'octokit'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'rubyzip'
end
