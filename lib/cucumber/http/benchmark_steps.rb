Given /^I am benchmarking$/ do
  @scenario_start_time = Time.now
end

Then 'the elapsed time should be less than {float} second(s)' do |time|
  elapsed = Time.now - @scenario_start_time

  expect(elapsed).to be < time
end
