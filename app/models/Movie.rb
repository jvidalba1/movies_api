require_relative 'day.rb'

DB = Sequel.connect('sqlite://db/movies.db')

class Movie < Sequel::Model
  one_to_many :days, class: :Day

  dataset_module do
    def by_day(day)
      association_join(:days).where(day: day).all
    end
  end

  # def self.by_day(day)
  #   DB[:movies].join(:days, movie_id: :id).where(day: day).all
  # end

  # def self.create(params)
  #   byebug
  #   DB[:movies].insert(params)
  # end
end

# class Post < Sequel::Model

# end
