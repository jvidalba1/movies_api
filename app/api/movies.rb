require 'sequel'
require 'byebug'
require_relative '../transactions/movie_transactions/index.rb'
require_relative '../transactions/movie_transactions/create.rb'

module MoviesApi
  class Ping < Grape::API
    extend MovieTransactions

    resource :movies do

      desc 'Create a movie'
      params do
        requires :name, type: String
        requires :description, type: String
        # requires :image_url, type: String
        requires :days, type: Array[String]
      end
      post do
        MovieTransactions::Create.call(params: params) do |m|
          m.success do |result|
            { movie: result }
          end
          m.failure do |failure|
            { error: "error" }
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
            { movies: result }
          end
          m.failure do |failure|
            { error: "error" }
          end
        end
      end
    end
  end
end
