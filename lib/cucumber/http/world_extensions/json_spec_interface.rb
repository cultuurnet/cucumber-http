require 'json_spec'
require 'json_spec/cucumber'

module JsonSpecInterface
  JsonSpec.directory = Cucumber::Http.data_directory

  def last_json
    response[:body]
  end

  def resolve(string)
    JsonSpec.remember(string)
  end
end
