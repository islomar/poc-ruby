require 'spec_helper'
require 'rack/test'


RSpec.describe 'hello app' do
  include Rack::Test::Methods
  
  it 'says hi' do
    get '/'

    expect(last_response).to be_ok
  end

end