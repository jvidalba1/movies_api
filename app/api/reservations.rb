module MoviesApi
  class Reservations < Grape::API

    resource :reservations do

      params do
        requires :date, type: String
      end
      desc 'Create a reservation for a movie given a date'
      post do
        #ToDo
      end

      params do
        requires :start_date, type: String
        requires :end_date, type: String
      end
      desc 'List of reservations given a date range'
      post do
        #ToDo
      end
    end
  end
end
