require_relative 'world_extensions/json_spec_interface'
require_relative 'world_extensions/url'
require_relative 'world_extensions/headers'
require_relative 'world_extensions/parameters'
require_relative 'world_extensions/payload'
require_relative 'world_extensions/request'
require_relative 'world_extensions/response'

World(JsonSpecInterface)
World(Cucumber::Http::Headers)
World(Cucumber::Http::Parameters)
World(Cucumber::Http::Payload)
World(Cucumber::Http::Request)
World(Cucumber::Http::Response)
World(Cucumber::Http::Url)

extend Cucumber::Http::Headers
extend Cucumber::Http::Parameters
extend Cucumber::Http::Payload
extend Cucumber::Http::Request
extend Cucumber::Http::Response
extend Cucumber::Http::Url
