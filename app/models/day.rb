require_relative 'movie.rb'

DB = Sequel.connect('sqlite://db/movies.db')

class Day < Sequel::Model
  many_to_one :movie, key: :movie_id, class: :Movie

  def validate
    super
    errors.add(:day, "can't be empty") if day.blank?
  end
end
