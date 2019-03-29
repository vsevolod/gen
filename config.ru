require_relative "config/environment.rb"

app = Rack::Builder.new do
  map '/' do
    run App
  end
end

run app
