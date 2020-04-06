require_relative '../base_transaction.rb'
require_relative '../../models/movie.rb'
require_relative '../../models/day.rb'

module MovieTransactions
  class Create < BaseTransaction
    tee :params
    step :create_movie
    step :create_days

    def params(input)
      @days = input.fetch(:params).delete(:days)
      @params = input.fetch(:params)
    end

    def create_movie
      @movie = Movie.new(@params)

      if @movie.save
        Success(@movie)
      else
        raise ValidationError(movie.errors)
      end
    rescue StandardError => exception
      Failure(error: exception)
    end

    def create_days
      @days.each do |str_day|
        day = Day.create(day: str_day)
        @movie.add_day(day)
      end
      Success({ movie: @movie, days: @days })
    rescue StandardError => exception
      Failure(error: exception)
    end
  end
end
