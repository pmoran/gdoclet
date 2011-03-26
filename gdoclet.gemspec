$: << File.expand_path("../lib", __FILE__)
require "gdoclet/version"

Gem::Specification.new do |gem|

  gem.name = "gdoclet"
  gem.summary = "Simple content management using Google Docs"
  gem.homepage = "http://github.com/pmoran/gdoclet"
  gem.authors = ["Peter Moran"]
  gem.email = "workingpeter@gmail.com"

  gem.version = GDoclet::VERSION.dup
  gem.platform = Gem::Platform::RUBY
  gem.add_runtime_dependency("nokogiri", "~> 1.4.4")
  gem.add_runtime_dependency("RedCloth", "4.2.3")
  gem.add_runtime_dependency("oauth", "~> 0.4.4")
  gem.add_runtime_dependency("dalli", "~> 1.0.2")

  gem.add_development_dependency("rake", "~> 0.8.7")
  gem.add_development_dependency("rspec", "~> 2.5.0")
  gem.add_development_dependency("sinatra", "~> 1.2.0")
  gem.add_development_dependency("fakeweb", "~> 1.3.0")
  gem.add_development_dependency("simplecov", "~> 0.4.1")

  gem.require_path = "lib"
  gem.files = Dir["lib/**/*", "README.markdown", "LICENSE"]
  gem.test_files = Dir["spec/**/*", "Rakefile"]

end