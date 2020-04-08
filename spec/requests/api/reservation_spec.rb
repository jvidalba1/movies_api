require 'spec_helper'

describe MoviesApi::Root, "MoviesApi::Reservation" do
  include Rack::Test::Methods

  def app
    MoviesApi::Root
  end

  let!(:movie) { Movie.create(title: "Avatar", description: "Fiction") }
  let!(:movie2) { Movie.create(title: "Rambo", description: "Action") }

  let!(:monday) { Day.create(name: 'monday') }
  let!(:friday) { Day.create(name: 'friday') }

  def set_reservations_for_index
    movie.add_day(monday)
    movie.add_day(friday)

    movie2.add_day(monday)

    show1 = Show.where(movie_id: movie.id, day_id: monday.id).first
    show2 = Show.where(movie_id: movie.id, day_id: friday.id).first
    show3 = Show.where(movie_id: movie2.id, day_id: monday.id).first

    reservation1 = Reservation.create(date: Date.parse("2020-04-06"), show_id: show1.id)
    reservation2 = Reservation.create(date: Date.parse("2020-04-10"), show_id: show2.id)
    reservation3 = Reservation.create(date: Date.parse("2020-04-06"), show_id: show3.id)
  end

  after(:each) do
    Reservation.all.each { |r| r.delete }
    Show.all.each { |s| s.delete }
    Movie.all.each { |m| m.delete }
    Day.all.each { |d| d.delete }
  end

  describe 'GET /api/reservations' do
    it 'returns HTTP status 200 given a date range' do
      get '/api/reservations?start_date=2020-04-01&end_date=2020-04-08'
      expect(last_response.status).to eq 200
    end

    it 'returns HTTP status 400 if date range is not set' do
      get '/api/reservations'
      expect(last_response.status).to eq 400
    end

    it 'returns HTTP status 200 and returns all reservations given a date range' do
      set_reservations_for_index()
      get '/api/reservations?start_date=2020-04-05&end_date=2020-04-08'
      expect(last_response.status).to eq 200
      expect(JSON.parse(last_response.body).count).to eq 2
      expect(JSON.parse(last_response.body)[0]["movie_name"]).to eq(movie.title)
      expect(JSON.parse(last_response.body)[1]["movie_name"]).to eq(movie2.title)
    end
  end

  describe 'POST /api/reservations' do
    before(:each) do
      movie.add_day(monday)
    end

    it 'returns HTTP status 400 and returns params missing message' do
      post '/api/reservations'
      expect(last_response.status).to eq 400
      expect(JSON.parse(last_response.body)).to eq({ "error"=>"movie_id is missing, date is missing" })
    end

    it 'returns HTTP status 400 and error for date sent' do
      post '/api/reservations', date: "2020-04-10", movie_id: movie.id
      expect(last_response.status).to eq 400
      expect(JSON.parse(last_response.body)).to eq({"error"=>["The movie is presented on monday"]})
    end

    it 'returns HTTP status 200 and returns specific info for reservation created' do
      show = Show.where(movie_id: movie.id, day_id: monday.id).first

      post '/api/reservations', date: "2020-04-06", movie_id: movie.id
      expect(last_response.status).to eq 201
      expect(JSON.parse(last_response.body)).to eq(
        {"message"=>"Your reservation has been created successfully.", "movie_name"=>movie.title}
      )
    end
  end
end
