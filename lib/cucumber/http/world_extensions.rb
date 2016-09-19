module JsonSpecInterface
  def last_json
    @response.body
  end

  def resolve(string)
    JsonSpec.remember(string)
  end
end

World(JsonSpecInterface)
