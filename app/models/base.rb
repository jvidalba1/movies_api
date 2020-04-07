module Base
  DB = Sequel.connect('sqlite://db/movies.db')
end
