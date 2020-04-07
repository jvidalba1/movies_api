require_relative 'day.rb'

DB = Sequel.connect('sqlite://db/movies.db')

class Movie < Sequel::Model
  one_to_many :shows
  many_to_many :days, join_table: :shows

  def validate
    super
    errors.add(:title, "can't be empty") if title.empty?
    errors.add(:description, "can't be empty") if description.empty?
  end

  dataset_module do
    def by_day(day)
      association_join(:days).where(name: day).all
    end
  end
end
