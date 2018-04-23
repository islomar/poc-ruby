require 'sinatra'
require "sinatra/json"

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

class TimeMachineAPI < Sinatra::Base
  HEADER_CONTENT_TYPE_JSON = { "Content-Type" => "application/json" }

  attr_reader :time_machine_service

  def initialize(time_machine_service)
    @time_machine_service = time_machine_service
  end

  get '/' do
    logger.info "LOG: KKKKK"
    'hello world to the root!!!!'
  end

  get '/hello_world' do
    'hello world'
  end

  get '/time' do
    response = {"time" => time_machine_service.now}
    
    [200, HEADER_CONTENT_TYPE_JSON, response.to_json]
  end

  post '/time/:data' do
    fake_time = params[:data]
    time_machine_service.freeze_time(fake_time)
    response = {"time" => fake_time}

    [201, HEADER_CONTENT_TYPE_JSON, response.to_json]
  end
end