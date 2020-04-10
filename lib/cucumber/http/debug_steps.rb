Then /^show me the request$/ do
  puts "Method: " + request[:method]
  puts "URL: " + request[:url]
  puts "Parameters: " + request[:parameters].inspect
  puts "Headers: " + request[:headers].inspect
  puts "Payload: " + request[:payload].to_s
end

Then /^show me the( unparsed)? response$/ do |unparsed|
  body = response[:body]

  if unparsed.nil?
    if response[:headers]['content-type'][0] =~ /json/
      body = JSON.pretty_generate(JSON.parse(response[:body]))
    elsif response[:headers]['content-type'][0] =~ /xml/
      body = Nokogiri::XML(response[:body])
    end
  end

  puts "Status: " + response[:status].to_s
  puts "Headers: " + response[:headers].map { |k,v| { k.split('-').map(&:capitalize).join('-') => v.join } }.reduce(:merge).to_s
  puts "Body: " + body
end

Then /^show me the kept values?$/ do
  puts JsonSpec.memory
end
