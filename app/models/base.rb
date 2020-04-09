module Base
  # DB = Sequel.connect('sqlite://db/movies.db')
  DB = Sequel.postgres('movies',
       user:'postgres',
       password: '',
       host: 'localhost',
       port: 5432,
       max_connections: 10)
end
