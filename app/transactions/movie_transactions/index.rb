require_relative '../base_transaction.rb'

module MovieTransactions
  class Index < BaseTransaction
    tee :get_day
    step :get_movies

    def get_day(input)
      params = input.fetch(:params)
      @day = params[:day].downcase
    end

    def get_movies(input)
      raise ParamsError.new("day not sent") if @day.blank?

      movies = Movie.by_day(@day)

      Success(movies)
    rescue StandardError => exception
      Failure(error: exception)
    end
  end
end
