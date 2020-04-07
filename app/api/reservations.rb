require 'sequel'
require 'byebug'
require_relative '../transactions/reservation_transactions/create.rb'
require_relative '../transactions/reservation_transactions/index.rb'
require_relative 'helpers/reservation_serializer.rb'

module MoviesApi
  class Reservation < Grape::API

    helpers ReservationSerializer

    resource :reservations do

      params do
        requires :movie_id, type: Integer
        requires :date, type: String
      end
      desc 'Create a reservation for a movie given a date'
      post do
        ReservationTransactions::Create.call(params: params) do |m|
          m.success do |result|
            serialize_reservation(result)
          end
          m.failure do |failure|
            error_message(failure)
          end
        end
      end

      params do
        requires :start_date, type: String
        requires :end_date, type: String
      end
      desc 'List of reservations given a date range'
      get do
        ReservationTransactions::Index.call(params: params) do |m|
          m.success do |result|
            serialize_reservations(result)
          end
          m.failure do |failure|
            error_message(failure)
          end
        end
      end
    end
  end
end
