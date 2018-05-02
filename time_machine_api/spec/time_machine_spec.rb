require 'rack/test'
require 'time_machine'
require 'net/http'
require 'uri'
require 'json'
require 'logger'

include Rack::Test::Methods

def app
  factory = Factory.new
  time_machine_service = factory.time_machine_service
  TimeMachineAPI.new(time_machine_service)
end

ANY_VALID_ISO8601_TIME = "2018-04-23T16:37:01+02:00"
ANY_INVALID_ISO8601_TIME = "invalid-iso8601-time"
INVALID_ISO8601_TIME_ERROR_MESSAGE = "The date passed must have a ISO8601 format"


describe "TimeMachineAPI" do
  describe "GET /time" do
    it "returns the time in iso8601 format" do
      allow(DateTime).to receive(:now).and_return(DateTime.parse(ANY_VALID_ISO8601_TIME))
      get '/time', { 'ACCEPT': 'application/json' }

      expect(last_response.status).to eq HTTP::Status::OK
      expect(last_response.body).not_to be_empty
      assert_content_is_json(last_response)
      assert_response_contains_expected_iso8601_time(last_response, ANY_VALID_ISO8601_TIME)
    end
  end

  describe "POST /time" do
    describe "when freezing a specific time" do
      it "returns the frozen time in the response" do
        # post_json('/time/' + ANY_VALID_ISO8601_TIME, {'time': ANY_VALID_ISO8601_TIME})
        post_json('/time/' + ANY_VALID_ISO8601_TIME)

        expect(last_response.status).to eq HTTP::Status::CREATED
        expect(last_response.body).not_to be_empty
        assert_content_is_json(last_response)
        assert_response_contains_expected_iso8601_time(last_response, ANY_VALID_ISO8601_TIME)
      end

      it "returns the frozen time when doing a GET request afterwards" do
        post_json('/time/' + ANY_VALID_ISO8601_TIME)

        get('/time', { 'ACCEPT' => 'application/json' })
        expected_response = {"time": ANY_VALID_ISO8601_TIME}
        expect(last_response.body).to eq(expected_response.to_json)
      end
    end

    it "returns 400 (Bad Request) if the time to be frozen does not have ISO8601 format" do
      post_json('/time/' + ANY_INVALID_ISO8601_TIME)

      expect(last_response.status).to eq HTTP::Status::BAD_REQUEST
      expect(last_response.body).to eq(INVALID_ISO8601_TIME_ERROR_MESSAGE)
    end
  end

  def assert_content_is_json(last_response)
    expect(last_response.headers['Content-Type']).to eq "application/json"
  end

  def assert_response_contains_expected_iso8601_time(last_response, expected_time)
    json_response = JSON.parse(last_response.body)
    expect(json_response).to eq({"time" => expected_time})
    expect{Time.iso8601(json_response["time"])}.not_to raise_error, INVALID_ISO8601_TIME_ERROR_MESSAGE
  end

  def post_json(uri, json={})
    header("Content-Type", "application/json")
    header("Accept", "application/json")
    post(uri, json.to_json)
  end
end