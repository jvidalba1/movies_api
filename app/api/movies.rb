module MoviesApi
  class Ping < Grape::API

    resource :movies do

      desc 'Create a movie'
      params do
        requires :name, type: String
        requires :description, type: String
        requires :image_url, type: String
        requires :days, type: Array[String]
      end
      post do
        #ToDo
      end

      params do
        requires :day, type: String
      end
      desc 'Return list of movies given a day of the week'
      get do
        #ToDo
      end
    end
  end
end
