module ReservationSerializer
  def serialize_reservation(data)
    {
      message: "Your reservation has been created successfully.",
      movie_name: data.title
    }
  end

  def serialize_reservations(data)
    data.map do |r|
      {
        id: r.id,
        date: r.date
      }
    end
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
