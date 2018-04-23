require 'rack/test'
require 'time_machine'
require 'json'

include Rack::Test::Methods

def app
  factory = Factory.new
  time_machine_service = factory.time_machine_service
  TimeMachineAPI.new(time_machine_service)
end

ANY_VALID_ISO8601_TIME = "2018-04-23T16:37:01+02:00"
ANY_INVALID_ISO8601_TIME = "invalid-iso8601-time"

describe "TimeMachineAPI" do
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
      post('/time/' + ANY_VALID_ISO8601_TIME, { 'CONTENT_TYPE': 'application/json', 'ACCEPT': 'application/json' })

      expect(last_response.status).to eq 201
      expect(last_response.headers['Content-Type']).to eq "application/json"
      assert_response_is_time_with_iso8601_format(last_response)
      get('/time', { 'ACCEPT' => 'application/json' })
      expected_response = {"time": ANY_VALID_ISO8601_TIME}
      expect(last_response.body).to eq(expected_response.to_json)
    end

    it "returns 422 if the time to be frozen does not have ISO8601 format" do
      post('/time/' + ANY_INVALID_ISO8601_TIME, { 'CONTENT_TYPE': 'application/json', 'ACCEPT': 'application/json' })

      expect(last_response.status).to eq 422
      expect(last_response.body).to eq("The date passed must have a ISO8601 format")
    end
  end

  def assert_response_is_time_with_iso8601_format(last_response)
    json_response = JSON.parse(last_response.body)
    expect(json_response.has_key?("time")).to be_truthy
    expect{Time.iso8601(json_response["time"])}.not_to raise_error, "The time received has no ISO8601 format"
  end
end