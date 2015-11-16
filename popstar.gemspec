$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "popstar/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "popstar"
  s.version     = Popstar::VERSION
  s.authors     = ["Alex Zanardo","Matteo Depalo","Eugenio Depalo"]
  s.email       = ["info@alexzanardo.com"]
  s.homepage    = "https://github.com/responsa/popstar"
  s.summary     = "Popularity system for your Rails models."
  s.description = "Popstar lets you add rules to determine your rails models popularity."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 3.2.6"
  s.add_dependency "mongoid", ">= 3.0.0"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency 'mongoid-rspec'
end
