require 'sinatra'
require './lib/my_app'

Factory = MyApp::Factory.new

enable :sessions

# Uncomment to pass the controllers and e2e tests:

get '/' do
    erb :index
end

get '/hello_world' do
  'hello world'
end

get '/time' do
  'hello world'
end