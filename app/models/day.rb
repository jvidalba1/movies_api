require_relative 'movie.rb'

DB = Sequel.connect('sqlite://db/movies.db')

class Day < Sequel::Model
  one_to_many :shows
  many_to_many :movies, join_table: :shows

  def validate
    super
    errors.add(:name, "can't be empty") if name.blank?
  end
end
