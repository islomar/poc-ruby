require 'sinatra'
require './lib/my_app'

Factory = MyApp::Factory.new

enable :sessions

# Uncomment to pass the controllers tests:

# get '/' do
# end