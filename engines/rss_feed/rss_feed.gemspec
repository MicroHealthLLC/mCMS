$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rss_feed/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rss_feed"
  s.version     = RssFeed::VERSION
  s.authors     = ["bilel"]
  s.email       = ["bilel.kedidi@gmail.com"]
  s.homepage    = ""
  s.summary     = " Summary of RssFeed."
  s.description = "Description of RssFeed."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.0", ">= 5.0.0.1"

  # s.add_development_dependency "sqlite3"
end
