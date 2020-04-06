require 'sequel'
# task default: %w[test]

desc "create all tables"
task :create_tables do
  DB = Sequel.connect('sqlite://db/movies.db')
  puts 'creating tables...'
  begin
    DB.create_table :movies do
      primary_key :id
      String :name
      String :description
      String :image_url
    end

    DB.create_table :days do
      primary_key :id
      foreign_key :movie_id, :movies
      String :day
    end

    DB.create_table :reservations do
      primary_key :id
      foreign_key :day_id, :days
      Date :date
    end
    puts "tables created"
  rescue Sequel::DatabaseError => e
    puts e.message
  end
end

desc "drop all tables"
task :drop_tables do
  DB = Sequel.connect('sqlite://db/movies.db')
  puts 'dropping tables...'
  begin
    DB.drop_table :movies

    DB.drop_table :days

    DB.drop_table :reservations
    puts 'tables dropped'
  rescue Sequel::DatabaseError => e
    puts e.message
  end
end
