module MovieTransactions
  class Create < BaseTransaction
    tee :params
    step :create_movie
    step :find_or_create_days

    def params(input)
      @days = input.fetch(:params).delete(:days).map(&:downcase)
      @params = input.fetch(:params)
    end

    def create_movie
      @movie = Movie.new(@params)

      if @movie.save
        Success(@movie)
      end
    rescue StandardError => exception
      Failure(error: exception)
    end

    def find_or_create_days
      raise ParamsError.new("days not sent") if @days.empty?

      @days.each do |str_day|
        day = Day.where(name: str_day).first || Day.create(name: str_day)
        @movie.add_day(day)
      end

      Success({ movie: @movie, days: @days })
    rescue StandardError => exception
      Failure(error: exception)
    end
  end
end
