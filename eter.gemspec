$:.push File.expand_path("../lib", __FILE__)

require "eter/version"

Gem::Specification.new do |s|
  s.name        = "eter"
  s.version     = Eter::VERSION
  s.authors     = ["Yuichi Takeuchi"]
  s.email       = ["info@takeyu-web.com"]
  s.homepage    = "http://takeyu-web.com/"
  s.summary     = "Extensible Template Engine for Ruby"
  s.description = ""

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "nokogiri"

  s.add_development_dependency "rspec"
  s.add_development_dependency "rspec-mocks"
end
