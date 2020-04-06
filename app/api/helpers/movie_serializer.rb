module MovieSerializer
  def serialize(data)
    data.map { |m| { id: m.id, name: m.name, description: m.description, day: m[:day] } }
  end

  def error_message(failure)
    { error: failure[:error].message }
  end
end
