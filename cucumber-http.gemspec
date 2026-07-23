$:.unshift File.expand_path('../lib', __FILE__)
require 'cucumber/http/version'

Gem::Specification.new do |s|
  s.name          = 'cucumber-http'
  s.version       = Cucumber::Http::VERSION
  s.licenses      = ['MIT']
  s.authors       = ['Kristof Willaert']
  s.email         = ['kristof.willaert@publiq.be']

  s.summary       = %q{Cucumber steps to easily test JSON APIs}
  s.description   = %q{Cucumber steps to easily test external JSON APIs}
  s.homepage      = "https://github.com/cultuurnet/cucumber-http"

  s.files         = Dir['lib/**/*', 'README.md']
  s.require_paths = ['lib']

  s.required_ruby_version = '>= 1.9.3'

  s.add_runtime_dependency 'cucumber'
  s.add_runtime_dependency 'json_spec'
  s.add_runtime_dependency 'rest-client'
  s.add_runtime_dependency 'faker'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'bundler'
end
