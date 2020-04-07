require 'sequel'

desc "create all tables"
task :create_tables do
  DB = Sequel.connect('sqlite://db/movies.db')
  puts 'creating tables...'
  begin
    DB.create_table :movies do
      primary_key :id
      String :title
      String :description
      String :image_url
    end

    DB.create_table :days do
      primary_key :id
      String :name
    end

    DB.create_table :shows do
      primary_key :id
      foreign_key :movie_id, :movies
      foreign_key :day_id, :days
    end

    DB.create_table :reservations do
      primary_key :id
      foreign_key :show_id, :shows
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
    DB.drop_table :shows
    DB.drop_table :reservations
    puts 'tables dropped'
  rescue Sequel::DatabaseError => e
    puts e.message
  end
end
