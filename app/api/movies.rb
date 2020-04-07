require_relative 'helpers/movie_serializer.rb'

module MoviesApi
  class Movie < Grape::API
    extend MovieTransactions

    helpers MovieSerializer

    resource :movies do

      desc 'Create a movie'
      params do
        requires :title, type: String
        requires :description, type: String
        optional :image_url, type: String
        requires :days, type: Array[String]
      end
      post do
        MovieTransactions::Create.call(params: params) do |m|
          m.success do |result|
            serialize_movie(result)
          end
          m.failure do |failure|
            error = error_message(failure)
            error! error[:errors], error[:code]
          end
        end
      end

      params do
        requires :day, type: String
      end
      desc 'Return list of movies given a day of the week'
      get do
        MovieTransactions::Index.call(params: params) do |m|
          m.success do |result|
            serialize_list(result)
          end
          m.failure do |failure|
            error = error_message(failure)
            error! error[:errors], error[:code]
          end
        end
      end
    end
  end
end
