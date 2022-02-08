# Cucumber::Http

This library provides Cucumber steps to test JSON HTTP API's. The
steps are rather verbose (technical) in nature, somewhat contrary to the
Cucumber philosophy of high-level, descriptive tests. This is intentional as
it allows these steps to be bundled in larger, more high-level tests by
non-developers.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cucumber-http'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cucumber-http

## Usage

### Bundled steps

#### Examples

Examples for testing the [REST API](https://apidoc.uitdatabank.be) of
[UiTDatabank](https://www.uitdatabank.be):

```ruby
@api @labels
Feature: Test the UDB3 labels API

  Background:
    Given I am using the UDB3 development environment
     And I am authorized as user "centraal_beheerder"
     And I send "application/json" and accept "application/ld+json"

  @labelcreate
  Scenario: Create label
    When I create a label with a random name of 10 characters
     And I keep the value of the JSON response at "uuid" as "uuid"
     And I send a GET request to "/labels/%{uuid}"
    Then the response status should be "200"
     And the JSON response at "visibility" should be "visible"
     And the JSON response at "privacy" should be "public"
```

#### Benchmarking

```ruby
Given /^I am benchmarking$/
```

```ruby
Then /^the elapsed time should be less than (#{CAPTURE_FLOAT}) seconds?$/
```

#### HTTP

```ruby
Given /^I set headers?:$/
```

```ruby
Given /^I send "(.*?)"$/
```

```ruby
Given /^I accept "(.*?)"$/
```

```ruby
Given /^I send and accept "(.*?)"$/
```

```ruby
Given /^I send "(.*?)" and accept "(.*?)"$/
```

```ruby
Given /^I send "(.*?)" and accept JSON$/
```

```ruby
Given /^I send and accept JSON$/
```

```ruby
Given /^I set the JSON request payload to:$/
```

```ruby
Given /^I set the JSON request payload from "(.*?)"$/
```

```ruby
When /^I send a (GET|POST|PATCH|PUT|DELETE) request to "([^"]*)"(?: with parameters?:)?$/
```

```ruby
Then /^the response status should( not)? be "(#{CAPTURE_INTEGER})"$/
```

```ruby
Then /^the response body should be valid JSON$/
```

#### Debugging

```ruby
Then /^show me the( unparsed)? response$/
```

```ruby
Then /^show me the kept values?$/
```

#### JSON (through JsonSpec)

These steps are documented in the [json_spec README](https://github.com/collectiveidea/json_spec#cucumber)

### Making larger, more descriptive tests

The steps in this library are overly technical for use in Cucumber as a communication
tool between developers and business people. They are meant to be encapsulated in
larger, more general steps through the use of the `steps` method in Cucumber.

This allows easier reuse of code and the ability for non-developers to write
requirements.

Examples for testing the [REST API](https://apidoc.uitdatabank.be) of
[UiTDatabank](https://www.uitdatabank.be):

Creating an organizer with a random name:
```ruby
When /^I create an organizer with a random name of (#{CAPTURE_INTEGER}) characters?$/ do |characters|
  name = Faker::Lorem.characters(characters)
  steps %Q{
    Given I am using the UDB3 development environment
      And I am authorized as user "centraal_beheerder"
      And I send and accept "application/json"
     When I set the JSON request payload to:
       """
       {"mainLanguage":"nl","website":"https://www.#{name}.be","name":"#{name}","contact":[]}
       """
      And I send a POST request to "/organizers/"
  }
end
```

Creating a role with a random name:
```ruby
When /^I create a role with a random name of (#{CAPTURE_INTEGER}) characters?$/ do |characters|
  name = Faker::Lorem.characters(characters)
  steps %Q{
    Given I am using the UDB3 development environment
      And I am authorized as user "centraal_beheerder"
      And I send and accept "application/json"
     When I set the JSON request payload to:
       """
       { "name": "#{name}" }
       """
      And I send a POST request to "/roles/"
  }
end
```

## Development

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/cucumber-http/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
