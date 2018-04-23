require 'sinatra'
require "sinatra/json"

class Factory
  def time_machine_service
    @time_machine_service ||= TimeMachineService.new()
  end
end

class InvalidIso8601DatetimeFormatError < StandardError
  attr_reader :messages

  def initialize()
    @messages = "The date passed must have a ISO8601 format"
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

  get '/time' do
    response = {"time" => time_machine_service.now}

    [200, HEADER_CONTENT_TYPE_JSON, response.to_json]
  end

  post '/time/:data' do
    begin
      fake_time = params[:data]
      validate(fake_time)
      time_machine_service.freeze_time(fake_time)
      response = {"time" => fake_time}

      [201, HEADER_CONTENT_TYPE_JSON, response.to_json]
    rescue InvalidIso8601DatetimeFormatError => ex
      [422, ex.messages]
    end
  end

  def validate(fake_time)
    begin
      Time.iso8601(fake_time)
    rescue
      raise InvalidIso8601DatetimeFormatError.new
    end
  end
end