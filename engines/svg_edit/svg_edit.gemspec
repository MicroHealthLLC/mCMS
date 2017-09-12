$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "svg_edit/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "svg_edit"
  s.version     = SvgEdit::VERSION
  s.authors     = ["bilel"]
  s.email       = ["bilel.kedidi@gmail.com"]
  s.summary     = "Summary of SvgEdit."
  s.description = "Description of SvgEdit."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.0", ">= 5.0.0.1"

end
