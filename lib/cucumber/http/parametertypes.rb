ParameterType(
  name: 'integer',
  regexp: /\d/,
  type: Integer,
  transformer: lambda do |integer_string|
    integer_string.to_i
  end
)

ParameterType(
  name: 'float',
  regexp: /[+-]?(?:0|[1-9]\d*)(?:\.(?:\d*[1-9]|0))?)/,
  type: Float,
  transformer: lambda do |float_string|
    float_string.to_f
  end
)
