module MovieSerializer
  def serialize_list(data)
    data.map do |m|
      {
        id: m[:movie_id],
        title: m[:title],
        description: m[:description],
        image_url: m[:image_url],
        day: m[:name]
      }
    end
  end

  def serialize_movie(data)
    {
      id: data[:movie].id,
      title: data[:movie].title,
      description: data[:movie].description,
      image_url: data[:movie].image_url,
      days: data[:days]
    }
  end

  def error_message(failure)
    { error: failure[:error].message }
  end
end
