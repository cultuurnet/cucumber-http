$:.unshift File.expand_path('../lib', __FILE__)
require 'cucumber/http/version'

Gem::Specification.new do |s|
  s.name          = 'cucumber-http'
  s.version       = Cucumber::Http::VERSION
  s.licenses      = ['MIT']
  s.authors       = ['Kristof Willaert']
  s.email         = ['kristof.willaert@publiq.be']

  s.summary       = %q{Cucumber steps to easily test XML and JSON APIs}
  s.description   = %q{Cucumber steps to easily test external XML and JSON APIs}
  s.homepage      = "https://github.com/cultuurnet/cucumber-http"

  s.files         = Dir['lib/**/*', 'README.md']
  s.require_paths = ['lib']

  s.required_ruby_version = '>= 1.9.3'

  s.add_runtime_dependency 'cucumber', '~> 2.0'
  s.add_runtime_dependency 'json_spec', '~> 1.1'
  s.add_runtime_dependency 'rest-client', '~> 2.0'
  s.add_runtime_dependency 'nokogiri', '~> 1.6'
  s.add_runtime_dependency 'faker', '~> 1.6'

  s.add_development_dependency 'rake', '~> 10.0'
  s.add_development_dependency 'bundler', '~> 1.9'
end
