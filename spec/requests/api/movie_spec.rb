require 'spec_helper'

describe MoviesApi::Root, "MoviesApi::Movie" do
  include Rack::Test::Methods

  def app
    MoviesApi::Root
  end

  let(:movie1) { Movie.create(title: "Test1", description: "drame") }
  let(:movie2) { Movie.create(title: "Test2", description: "action") }
  let(:movie3) { Movie.create(title: "Test3", description: "action") }

  let(:monday) { Day.create(name: 'monday') }
  let(:friday) { Day.create(name: 'friday') }

  after(:each) do
    Reservation.all.each { |r| r.delete }
    Show.all.each { |s| s.delete }
    Movie.all.each { |m| m.delete }
    Day.all.each { |d| d.delete }
  end

  it 'returns a 404 error if the url does not match' do
    get "/api/whatever"
    expect(last_response.status).to eq 404
  end

  describe 'GET /api/movies' do
    it 'returns HTTP status 200' do
      get '/api/movies?day=friday'
      expect(last_response.status).to eq 200
    end

    it 'returns HTTP status 400 if day is not set' do
      get '/api/movies?day='
      expect(last_response.status).to eq 400
    end

    it 'returns all movies information given a day' do
      movie1.add_day(monday)
      movie2.add_day(friday)
      movie3.add_day(friday)

      get '/api/movies?day=friday'
      expect(last_response.status).to eq 200
      expect(JSON.parse(last_response.body)).to eq(
        [
          { "day"=>"friday", "description"=>movie2.description, "id"=>movie2.id, "image_url"=>movie2.image_url, "title"=>movie2.title },
          { "day"=>"friday", "description"=>movie3.description, "id"=>movie3.id, "image_url"=>movie3.image_url, "title"=>movie3.title }
        ]
      )
    end
  end

  describe 'POST /api/movies' do
    it 'returns HTTP status 400 and returns params missing message' do
      post '/api/movies', title: "oelo"
      expect(last_response.status).to eq 400
      expect(JSON.parse(last_response.body)).to eq({ "error"=>"description is missing, days is missing" })
    end

    it 'returns HTTP status 400 and returns specific errors for params' do
      post '/api/movies', title: "", description: "", days: ['monday']
      expect(last_response.status).to eq 400
      expect(JSON.parse(last_response.body)).to eq(
        { "error"=>["title can't be empty", "description can't be empty"] }
      )
    end

    it 'returns HTTP status 400 and returns specific errors for days not sent' do
      post '/api/movies', title: "test", description: "desc", days: [ "" ]
      expect(last_response.status).to eq 400
      expect(JSON.parse(last_response.body)).to eq({ "error" => [ "name day can't be empty" ] })
    end

    it 'returns HTTP status 200 and returns movie info created' do
      post '/api/movies', title: "Rambo", description: "action", days: [ "monday", "friday" ]
      expect(last_response.status).to eq 201
      expect(JSON.parse(last_response.body)["title"]).to eq("Rambo")
      expect(JSON.parse(last_response.body)["days"]).to eq(["monday", "friday"])
    end
  end
end
