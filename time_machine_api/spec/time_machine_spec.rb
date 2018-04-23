require 'rack/test'
require 'time_machine'
require 'json'

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
    it "returns the time in iso8601 format" do
      get '/time', {'ACCEPT': 'application/json' }

      expect(last_response.status).to eq 200
      expect(last_response.body).not_to be_empty
      expect(last_response.headers['Content-Type']).to eq "application/json"
      assert_response_is_time_with_iso8601_format(last_response)
    end
  end

  describe "POST /time" do
    it "freezes a fake time" do
      any_fake_time = "any-fake-time"
      post('/time/' + "#{any_fake_time}", { 'CONTENT_TYPE': 'application/json', 'ACCEPT': 'application/json' })

      expect(last_response.status).to eq 201
      expect(last_response.headers['Content-Type']).to eq "application/json"
      # assert_response_is_time_with_iso8601_format(last_response)
      get('/time', { 'ACCEPT' => 'application/json' })
      expected_response = {"time": any_fake_time}
      expect(last_response.body).to eq(expected_response.to_json)
    end
  end

  def assert_response_is_time_with_iso8601_format(last_response)
    json_response = JSON.parse(last_response.body)
    expect(json_response.has_key?("time")).to be_truthy
    expect{Time.iso8601(json_response["time"])}.not_to raise_error, "The time received has no ISO8601 format"
  end
end