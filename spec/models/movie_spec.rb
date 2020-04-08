require 'spec_helper'
require_relative '../../app/models/movie.rb'
require_relative '../../app/models/day.rb'
require_relative '../../app/models/base.rb'
require_relative '../../app/models/show.rb'
require_relative '../../app/models/reservation.rb'

describe "Sequel::Movie" do
  after(:each) do
    Show.all.each { |m| m.delete }
    Movie.all.each { |m| m.delete }
    Day.all.each { |m| m.delete }
    Reservation.all.each { |m| m.delete }
  end

  describe "Validations" do
    describe "Title" do
      it "returns valid true with title" do
        movie = Movie.new(title: "valid title", description: "Desc")
        expect(movie.valid?).to eq(true)
      end

      it "returns valid false without title" do
        movie = Movie.new(title: "", description: "Desc")
        expect(movie.valid?).to eq(false)
      end
    end

    describe "Description" do
      it "returns valid true with description" do
        movie = Movie.new(title: "valid title", description: "Desc")
        expect(movie.valid?).to eq(true)
      end

      it "returns valid false without title" do
        movie = Movie.new(title: "valid title", description: "")
        expect(movie.valid?).to eq(false)
      end
    end
  end

  describe "dataset" do
    it "returns all the movies in the database" do
      movie1 = Movie.create(title: "Rambo 1", description: "test desc")
      movie2 = Movie.create(title: "Rambo 2", description: "testing")
      expect(Movie.count).to eq(2)
      expect(Movie.all).to eq([movie1, movie2])
    end

    describe("#by_day") do
      before(:each) do
        @movie1 = Movie.create(title: "Test1", description: "drame")
        @movie2 = Movie.create(title: "Test2", description: "action")

        @monday = Day.create(name: 'monday')
        @tuesday = Day.create(name: 'tuesday')
        @wednesday = Day.create(name: 'wednesday')
        @thursday = Day.create(name: 'thursday')
        @friday = Day.create(name: 'friday')
        @saturday = Day.create(name: 'saturday')
        @sunday = Day.create(name: 'sunday')

        @movie1.add_day(@monday)
        @movie1.add_day(@wednesday)

        @movie2.add_day(@monday)
        @movie2.add_day(@friday)
      end

      it "returns all the movies given a day of the week" do
        mapped_movies = Movie.by_day('monday').map{ |m| { movie_id: m[:movie_id], title: m[:title] } }

        expect(Movie.by_day('monday').count).to eq(2)
        expect(mapped_movies).to eq(
          [
            { movie_id: @movie1.id, title: @movie1.title },
            { movie_id: @movie2.id, title: @movie2.title }
          ]
        )
      end

      it "returns no movies given a day of the week does not match with any day" do
        expect(Movie.by_day('sunday').count).to eq(0)
        expect(Movie.by_day('sunday')).to eq([])
      end
    end
  end
end

