require_relative '../base_transaction.rb'
require_relative '../../models/movie.rb'

module MovieTransactions
  class Index < BaseTransaction
    tee :get_day
    step :get_movies

    def get_day(input)
      params = input.fetch(:params)
      @day = params[:day]
    end

    def get_movies(input)
      movies = Movie.by_day(@day)
      raise TypeError, "Something went wrong!"
      Success(movies)
    rescue StandardError => exception
      Failure(error: exception)
    end
  end
end
