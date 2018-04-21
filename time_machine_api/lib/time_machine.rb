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