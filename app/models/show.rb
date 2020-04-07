require_relative 'movie.rb'
require_relative 'day.rb'

DB = Sequel.connect('sqlite://db/movies.db')

class Show < Sequel::Model
  many_to_one :movie
  many_to_one :day

  one_to_many :reservations
end
