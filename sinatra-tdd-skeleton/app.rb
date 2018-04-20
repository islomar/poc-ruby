require 'sinatra'
require './lib/my_app'

Factory = MyApp::Factory.new

enable :sessions

# Uncomment to pass the controllers and e2e tests:

get '/' do
    erb :index
end