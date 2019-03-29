require 'sinatra'

class App < Sinatra::Application # :nodoc:
  set :public_folder, 'assets'

  get '/' do
    slim :index
  end
end
