require_relative 'day.rb'

DB = Sequel.connect('sqlite://db/movies.db')

class Movie < Sequel::Model
  one_to_many :days, class: :Day

  def validate
    super
    errors.add(:name, "can't be empty") if name.empty?
    errors.add(:description, "can't be empty") if description.empty?
    errors.add(:description, "can't be empty") if description.empty?
  end

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
