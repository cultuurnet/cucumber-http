Given /^I set headers?:$/ do |hdrs|
  hdrs.rows_hash.each { |name, value| add_header(name, value) }
end

Given /^I send "(.*?)"$/ do |content_type|
  steps %Q{
    Given I set headers:
      | Content-Type | #{content_type} |
  }
end

Given /^I accept "(.*?)"$/ do |accept_type|
  steps %Q{
    Given I set headers:
      | Accept       | #{accept_type} |
  }
end

Given /^I send and accept "(.*?)"$/ do |type|
  steps %Q{
    Given I set headers:
      | Content-Type | #{type} |
      | Accept       | #{type} |
  }
end

Given /^I send "(.*?)" and accept "(.*?)"$/ do |content_type, accept_type|
  steps %Q{
    Given I set headers:
      | Content-Type | #{content_type} |
      | Accept       | #{accept_type}  |
  }
end

Given /^I send "(.*?)" and accept JSON$/ do |content_type|
  steps %Q{
    Given I set headers:
      | Content-Type | #{content_type}  |
      | Accept       | application/json |
  }
end

Given /^I send and accept JSON$/ do
  steps %Q{
    Given I set headers:
      | Content-Type | application/json |
      | Accept       | application/json |
  }
end

Given(/^I set the JSON request payload to '(.*?)'$/) do |payload|
  set_payload(JSON.parse(resolve(payload)).to_json)
end

Given(/^I set the JSON request payload to:$/) do |payload|
  set_payload(JSON.parse(resolve(payload)).to_json)
end

Given(/^I set the JSON request payload from "(.*?)"$/) do |filename|
  path = "#{Cucumber::Http.data_directory}/#{filename}"

  if File.file? path
    set_payload(JSON.parse(resolve(File.read(path))).to_json)
  else
    raise "File not found: '#{path}'"
  end
end

Given 'I set the form data properties to:' do |table|
  table.rows_hash.each { |name, value| add_multipart_payload(name, value) }

  remove_header('Content-Type')
  add_multipart_payload('multipart', true)
end

When /^I send a (GET|POST|PATCH|PUT|DELETE) request to "([^"]*)"(?: with parameters?:)?$/ do |*args|
  method = args.shift
  endpoint = resolve(args.shift)
  params = args.shift

  request_url = URI.join(url, URI::encode(endpoint)).to_s

  unless params.nil?
    if params.class == Cucumber::MultilineArgument::DataTable
      params_hash = params.rows_hash
    else
      params_hash  = Hash[params.split('&').inject([]) { |result, param| result << param.split('=') }]
    end

    params_hash.each { |name, value| add_parameter(name, resolve(value)) }
  end

  perform_request(method, request_url)
end

When 'I upload {string} from path {string} to {string}' do |key, filename, endpoint|
  method      = 'post'
  payload_key = key
  path        = "#{Cucumber::Http.data_directory}/#{filename}"

  request_url = URI.join(url, URI::encode(endpoint)).to_s

  if File.file? path
    remove_header('Content-Type')
    add_multipart_payload(payload_key, File.new(path, 'rb'))
  else
    raise "File not found: '#{path}'"
  end

  perform_request(method, request_url)
end

When /^(?:I )?keep the value of the (?:JSON|json)(?: response)?(?: at "(.*)")? as "(.*)"$/ do |path, key|
  JsonSpec.memorize(key, parse_json(last_json, path))
end

Then 'the response status should be "{int}"' do |status_code|
  expect(response[:status]).to eq(status_code)
end

Then 'the response status should not be "{int}"' do |status_code|
  expect(response[:status]).not_to eq(status_code)
end

Then /^the response body should be valid JSON$/ do
  expect { JSON.parse(response[:body]) }.not_to raise_error
end
