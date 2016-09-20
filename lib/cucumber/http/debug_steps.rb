Then /^show me the( unparsed)? response$/ do |unparsed|
  if unparsed
    puts response[:body]
  elsif response[:headers]['Content-Type'] =~ /json/
    puts JSON.pretty_generate(JSON.parse(response['body']))
  elsif response[:headers]['Content-Type'] =~ /xml/
    puts Nokogiri::XML(response[:body])
  else
    puts response[:headers]
    puts response[:body]
  end
end

Then /^show me the kept values?$/ do
  puts JsonSpec.memory
end
