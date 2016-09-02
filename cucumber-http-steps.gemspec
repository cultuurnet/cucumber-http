$:.unshift File.expand_path('../lib', __FILE__)
require 'cucumber/http/steps/version'

Gem::Specification.new do |s|
  s.name          = 'cucumber-http-steps'
  s.version       = Cucumber::Http::Steps::VERSION
  s.licenses      = ['MIT']
  s.authors       = ['Kristof Willaert']
  s.email         = ['kristof.willaert@cultuurnet.be']

  s.summary       = %q{Cucumber steps to easily test XML and JSON APIs}
  s.description   = %q{Cucumber steps to easily test external XML and JSON APIs}
  s.homepage      = "TODO: Put your gem's website or public repo URL here."

  s.files         = Dir['lib/**/*', 'README.md']
  s.require_paths = ['lib']

  s.required_ruby_version = '>= 1.9.3'

  s.add_runtime_dependency 'cucumber', '~> 2.0'

  s.add_development_dependency 'rake', '~> 10.0'
  s.add_development_dependency 'bundler', '~> 1.9'
end
