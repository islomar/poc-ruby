require 'rack/test'

include Rack::Test::Methods

class Factory
  def time_machine_service
    @time_machine_service ||= TimeMachineService.new()
  end
end


class TimeMachineService

  attr_accessor :fake_time

  def now
    result = fake_time || DateTime.now.iso8601
    return result
  end

  def freeze_time(fake_time)
    @fake_time = fake_time
  end

end
require 'sinatra'


class TimeMachineAPI < Sinatra::Base
  HEADER_CONTENT_TYPE_JSON = { "Content-Type" => "application/json" }

  attr_reader :time_machine_service

  def initialize(time_machine_service)
    @time_machine_service = time_machine_service
  end

  get '/hello_world' do
    'hello world'
  end

  get '/time' do
    now = time_machine_service.now

    [200, HEADER_CONTENT_TYPE_JSON, now.to_json]
  end

  post '/time/:data' do
    fake_time = params[:data]
    time_machine_service.freeze_time(fake_time)

    [201, HEADER_CONTENT_TYPE_JSON, fake_time.to_json]
  end
end


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
      post('/time/my-fake-datetime', { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' })

      expect(last_response.status).to eq 201
      expect(last_response.body).not_to be_nil
      get('/time', { 'ACCEPT' => 'application/json' })
      expect(last_response.body).to eq "\"my-fake-datetime\""
    end
  end
end