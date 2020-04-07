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
    if (failure[:error].class == Sequel::ValidationFailed || failure[:error].class == ParamsError)
      { errors: failure[:error].message.split(", "), code: 400 }
    elsif failure[:error].class == NotFoundError
      { errors: failure[:error].message.split(", "), code: 404 }
    else
      { errors: "Internal server error.", code: 500 }
    end
  end
end
