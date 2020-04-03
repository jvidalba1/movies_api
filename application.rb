require 'grape'

# Load files from the models and api folders
Dir["#{File.dirname(__FILE__)}/app/api/*.rb"].each { |f| require f }

# Grape API class. We will inherit from it in our future controllers.
module MoviesApi
  class Root < Grape::API
    format :json
    prefix :api

    mount MoviesApi::Ping

    # Simple endpoint to get the current status of our API.
    get :status do
      { status: 'ok' }
    end
  end
end

# Mounting the Grape application
Application = Rack::Builder.new do
  map "/" do
    run MoviesApi::Root
  end
end
