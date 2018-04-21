require 'rack/test'
require 'time_machine'

include Rack::Test::Methods

def app
  factory = Factory.new
  time_machine_service = factory.time_machine_service
  TimeMachineAPI.new(time_machine_service)
end


describe "TimeMachineAPI" do
  describe "GET /hello_world" do
    it "returns 200" do
      get '/hello_world'

      expect(last_response.status).to eq 200
    end
  end

  describe "GET /time" do
    it "returns the time in iso8601" do
      get '/time', {'ACCEPT' => 'application/json' }

      expect(last_response.status).to eq 200
      expect(last_response.body).not_to be_nil
      # expect(last_response.body).to eq "2018-04-21T09:35:20+00:00"
    end
  end

  describe "POST /time" do
    it "freezes a fake time" do
      any_fake_time = "any-fake-time"
      post('/time/' + "#{any_fake_time}", { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' })

      expect(last_response.status).to eq 201
      expect(last_response.body).not_to be_nil
      get('/time', { 'ACCEPT' => 'application/json' })
      expect(last_response.body).to eq "\"#{any_fake_time}\""
    end
  end
end