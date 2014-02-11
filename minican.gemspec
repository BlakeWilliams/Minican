$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "minican/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "minican"
  s.version     = Minican::VERSION
  s.authors     = ["Blake Williams"]
  s.email       = ["blake@blakewilliams.me"]
  s.homepage    = "http://github.com/BlakeWilliams/Minican"
  s.summary     = "Miniature authorization for Rails."
  s.description = "Miniature authorization for Rails."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "activesupport", ">= 3.0.0"

  s.add_development_dependency "rake"
  s.add_development_dependency "rspec", "~> 3.0.0.beta1"
  s.add_development_dependency "yard", "~> 0.8.7.3"
end
