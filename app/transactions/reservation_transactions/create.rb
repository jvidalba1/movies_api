require_relative '../base_transaction.rb'
require_relative '../../models/movie.rb'
require_relative '../../models/day.rb'
require_relative '../../models/show.rb'
require_relative '../../models/reservation.rb'
require_relative '../../errors/validation_error.rb'

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
        raise ValidationError.new("movie not found")
      end
    rescue StandardError => exception
      Failure(error: exception)
    end

    def validate_day

      @day = Day.where(name: @day_str).first

      if @day.movies.include?(@movie)
        Success(@movie)
      else
        raise ValidationError.new("This movie is presented on --")
      end

    rescue StandardError => exception
      Failure(error: exception)
    end

    def get_show
      @show = Show.where(movie_id: @movie.id, day_id: @day.id).first

      if @show
        Success(@show)
      else
        raise ValidationError.new("show not found")
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
  end
end
