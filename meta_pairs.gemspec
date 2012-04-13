$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "meta_pairs/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "meta_pairs"
  s.version     = MetaPairs::VERSION
  s.authors     = ["Barry Paul"]
  s.email       = ["bpaul@planet-hood.com"]
  s.homepage    = "https://github.com/qstream/meta_pairs"
  s.summary     = "Summary of MetaPairs."
  s.description = "Description of MetaPairs."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.1.4"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
end
