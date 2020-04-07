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
    { error: failure[:error].message }
  end
end
