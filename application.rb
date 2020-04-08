require 'grape'
require 'sequel'
require 'dry-transaction'
require 'byebug'

# Load files from the models and api folders
# byebug
Dir["#{File.dirname(__FILE__)}/app/**/*.rb"].each { |f| require f }

# Grape API class. We will inherit from it in our future controllers.
module MoviesApi
  class Root < Grape::API
    format :json
    prefix :api

    mount MoviesApi::Movie
    mount MoviesApi::Reservation


    get '/status' do
      { oelo: "oelo" }
    end
  end
end

# Mounting the Grape application
Application = Rack::Builder.new do
  map "/" do
    run MoviesApi::Root
  end
end
