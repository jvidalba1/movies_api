require_relative '../base_transaction.rb'
require_relative '../../models/movie.rb'

module MovieTransactions
  class Create < BaseTransaction
    tee :params
    step :validate
    step :create_movie

    def params(input)
      @days = input.fetch(:params).delete(:days)
      @params = input.fetch(:params)
    end

    def validate

    end

    def create_movie
      movie = Movie.create(@params)
      Success(movie)
    rescue StandardError => exception
      Failure(error: exception)
    end
  end
end
