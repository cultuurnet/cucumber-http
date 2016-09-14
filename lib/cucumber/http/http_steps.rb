require 'rest-client'
require 'nokogiri'
require 'json_spec'

Before do
  @url = nil
  @headers = Hash.new
  @params = Hash.new
  @payload = nil
end

def last_json
  @response.body
end

def resolve(string)
  JsonSpec.remember(string)
end

Given /^I set headers?:$/ do |headers|
  headers.rows_hash.each { |k, v| @headers[k] = v }
end

Given /^I send "(.*?)" and accept (XML|JSON)$/ do |content_type, accept_type|
  steps %Q{
    Given I set headers:
      | Accept       | application/#{accept_type.downcase} |
      | Content-Type | #{content_type}                     |
  }
end

Given /^I send and accept (XML|JSON)$/ do |type|
  steps %Q{
    Given I set headers:
      | Accept       | application/#{type.downcase} |
      | Content-Type | application/#{type.downcase} |
  }
end

Given(/^I set the JSON request payload to '(.*?)'$/) do |payload|
  @payload = JSON.parse(payload)
end

Given(/^I set the JSON request payload to:$/) do |payload|
  @payload = JSON.parse(payload)
end

Given(/^I set the JSON request payload from "(.*?)"$/) do |filename|
  path = "#{Dir.pwd}/features/support/data/#{filename}"

  if File.file? path
    @payload = JSON.parse File.read(path)
  else
    raise "File not found: '#{path}'"
  end
end

When /^I send a (GET|POST|PATCH|PUT|DELETE) request to "([^"]*)"(?: with parameters?:)?$/ do |*args|
  method = args.shift
  endpoint = resolve(args.shift)
  params = args.shift

  request_url = @url ? URI.join(@url, endpoint).to_s : endpoint

  unless params.nil?
    if params.class == Cucumber::MultilineArgument::DataTable
      @headers['params'] = params.rows_hash
    else
      @headers['params'] = Hash[params.split('&').inject([]) { |result, param| result << param.split('=') }]
    end
  end

  begin
    @response = RestClient::Request.execute(
      method: method.downcase,
      url: request_url,
      payload: @payload.to_json,
      headers: @headers
    )
  rescue RestClient::Exception => e
    @response = e.response
  end
end

When /^(?:I )?keep the value of the (?:JSON|json)(?: response)?(?: at "(.*)")? as "(.*)"$/ do |path, key|
  JsonSpec.memorize(key, parse_json(last_json, path))
end

Then /^show me the( unparsed)? response$/ do |unparsed|
  if unparsed
    puts @response.body
  elsif @response.headers['Content-Type'] =~ /json/
    puts JSON.pretty_generate(JSON.parse(@response.body))
  elsif @response.headers['Content-Type'] =~ /xml/
    puts Nokogiri::XML(@response.body)
  else
    puts @response.headers
    puts @response.body
  end
end

Then /^the response status should( not)? be "(#{CAPTURE_INTEGER})"$/ do |negative, status_code|
  negative ? expect(@response.code).not_to(eq(status_code)) : expect(@response.code).to(eq(status_code))
end

Then /^the response body should be valid (XML|JSON)$/ do |type|
  case type
  when 'XML'
    expect { Nokogiri::XML(@response.body) { |config| config.strict } }.not_to raise_error
  when 'JSON'
    expect { JSON.parse(@response.body) }.not_to raise_error
  end
end

Then /^the JSON response should( not)? be '([^']*)'$/ do |negative, expected_response|
  expected = JSON.parse(expected_response)
  actual = JSON.parse(@response.body)

  method = negative ? "not_to" : "to"
  eval "expect actual.#{method} eq(expected)"
end

Then /^the JSON response should( not)? be:$/ do |negative, expected_response|
  expected = JSON.parse(expected_response)
  actual = JSON.parse(@response.body)

  negative ? expect(actual).not_to(eq(expected)) : expect(actual).to(eq(expected))
end
