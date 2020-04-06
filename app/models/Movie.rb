DB = Sequel.connect('sqlite://db/movies.db')

class Movie

  def self.by_day(day)
    DB[:movies].join(:days, movie_id: :id).where(day: day).all
  end

  def self.create(params)
    byebug
    DB[:movies].insert(params)
  end
end
