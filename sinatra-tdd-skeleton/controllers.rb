require 'sinatra'
require './lib/my_app'

Factory = MyApp::Factory.new

enable :sessions