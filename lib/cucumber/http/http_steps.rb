require 'nokogiri'
require 'json_spec'

Given /^I set headers?:$/ do |hdrs|
  hdrs.rows_hash.each { |name, value| add_header(name, value) }
end

Given /^I send "(.*?)" and accept (XML|JSON)$/ do |content_type, accept_type|
  steps %Q{
    Given I set headers:
      | Content-Type | #{content_type}                     |
      | Accept       | application/#{accept_type.downcase} |
  }
end

Given /^I send and accept (XML|JSON)$/ do |type|
  steps %Q{
    Given I set headers:
      | Content-Type | application/#{type.downcase} |
      | Accept       | application/#{type.downcase} |
  }
end

Given(/^I set the JSON request payload to '(.*?)'$/) do |payload|
  set_payload(JSON.parse(resolve(payload)).to_json)
end

Given(/^I set the JSON request payload to:$/) do |payload|
  set_payload(JSON.parse(resolve(payload)).to_json)
end

Given(/^I set the JSON request payload from "(.*?)"$/) do |filename|
  path = "#{Dir.pwd}/features/support/data/#{filename}"

  if File.file? path
    set_payload(JSON.parse(resolve(File.read(path))).to_json)
  else
    raise "File not found: '#{path}'"
  end
end

When /^I send a (GET|POST|PATCH|PUT|DELETE) request to "([^"]*)"(?: with parameters?:)?$/ do |*args|
  method = args.shift
  endpoint = resolve(args.shift)
  params = args.shift

  request_url = URI.join(url, endpoint).to_s

  unless params.nil?
    if params.class == Cucumber::MultilineArgument::DataTable
      params_hash = params.rows_hash
    else
      params_hash  = Hash[params.split('&').inject([]) { |result, param| result << param.split('=') }]
    end

    params_hash.each { |name, value| add_parameter(name, value) }
  end

  perform_request(method, request_url)
end

When /^(?:I )?keep the value of the (?:JSON|json)(?: response)?(?: at "(.*)")? as "(.*)"$/ do |path, key|
  JsonSpec.memorize(key, parse_json(last_json, path))
end

Then /^the response status should( not)? be "(#{CAPTURE_INTEGER})"$/ do |negative, status_code|
  if negative
    expect(response[:status]).not_to eq(status_code)
  else
    expect(response[:status]).to eq(status_code)
  end
end

Then /^the response body should be valid (XML|JSON)$/ do |type|
  case type
  when 'XML'
    expect { Nokogiri::XML(response[:body]) { |config| config.strict } }.not_to raise_error
  when 'JSON'
    expect { JSON.parse(response[:body]) }.not_to raise_error
  end
end

Then /^the JSON response should( not)? be '([^']*)'$/ do |negative, expected_response|
  expected = JSON.parse(expected_response)
  actual = JSON.parse(response[:body])

  if negative
    expect(actual).not_to eq(expected)
  else
    expect(actual).to eq(expected)
  end
end

Then /^the JSON response should( not)? be:$/ do |negative, expected_response|
  expected = JSON.parse(expected_response)
  actual = JSON.parse(response[:body])

  if negative
    expect(actual).not_to eq(expected)
  else
    expect(actual).to eq(expected)
  end
end
