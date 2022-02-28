require 'cucumber/http/configuration'

module Cucumber
  module Http
    extend Configuration
  end
end

require 'cucumber/http/world_extensions'
require 'cucumber/http/hooks'
require 'cucumber/http/http_steps'
require 'cucumber/http/benchmark_steps'
require 'cucumber/http/debug_steps'
