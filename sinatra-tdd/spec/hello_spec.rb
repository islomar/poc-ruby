require 'spec_helper'

RSpec.describe 'hello app' do
  it 'says hi' do
    get '/'

    expect(last_response).to be_ok
  end

end