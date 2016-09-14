CAPTURE_INTEGER = Transform /^(-?\d+)$/ do |number_string|
  number_string.to_i
end

CAPTURE_FLOAT = Transform /^(-?[\d.]+)$/ do |number_string|
  number_string.to_f
end
