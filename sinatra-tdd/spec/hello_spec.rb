require 'spec_helper'
require 'rack/test'
require_relative '../hello'


RSpec.describe 'hello app' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'says hi' do
    get '/'

    expect(last_response).to be_ok
  end

end