$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "event_calendar/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "event_calendar"
  s.version     = EventCalendar::VERSION
  s.authors     = ["bilel"]
  s.email       = ["bilel.kedidi@gmail.com"]
  s.summary     = "Summary of EventCalendar."
  s.description = "Description of EventCalendar."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.0", ">= 5.0.0.1"
  s.add_dependency "simple_calendar", "~> 2.0"
end
