require_relative '../base_transaction.rb'

module ReservationTransactions
  class Create < BaseTransaction
    tee :params
    step :get_movie
    step :validate_day
    step :get_show
    step :create_reservation

    def params(input)
      params = input.fetch(:params)
      @date = Date.parse(params[:date])
      @movie_id = params[:movie_id]
      @day_str = @date.strftime('%A').downcase
    end

    def get_movie
      @movie = Movie.where(id: @movie_id).first

      if @movie
        Success(@movie)
      else
        raise NotFoundError.new("Movie not found.")
      end
    rescue StandardError => exception
      Failure(error: exception)
    end

    def validate_day
      @day = Day.where(name: @day_str).first

      if @day && @day.movies.include?(@movie)
        Success(@movie)
      else
        raise ParamsError.new("The movie is presented on #{days_for_movie}")
      end

    rescue StandardError => exception
      Failure(error: exception)
    end

    def get_show
      @show = Show.where(movie_id: @movie.id, day_id: @day.id).first

      if @show
        Success(@show)
      else
        raise NotFoundError.new("Movie or days not found.")
      end
    rescue StandardError => exception
      Failure(error: exception)
    end

    def create_reservation
      @reservation = Reservation.new(date: @date, show_id: @show.id)

      if @reservation.save
        Success(@movie)
      end
    rescue StandardError => exception
      Failure(error: exception)
    end

    private

    def days_for_movie
      @movie.days.map(&:name).join('- ')
    end
  end
end
