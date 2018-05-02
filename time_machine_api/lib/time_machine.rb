require 'sinatra'
require "sinatra/json"
require 'httpclient'
require 'logger'

require_relative './factory'
require_relative './errors'


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
  configure :production, :development do
    enable :logging
  end


  HEADER_CONTENT_TYPE_JSON = { "Content-Type" => "application/json" }

  attr_reader :time_machine_service

  def initialize(time_machine_service)
    super()
    @time_machine_service = time_machine_service
  end

  get '/time' do
    response = {"time" => time_machine_service.now}

    [HTTP::Status::OK, HEADER_CONTENT_TYPE_JSON, response.to_json]
  end

  post '/time/:data' do
    begin
      request.body.rewind
      logger.info headers
      logger.info ">>> BODY: " + request.body.read
      # puts JSON.parse(request.body.read)
      fake_time = params[:data]
      validate(fake_time)
      time_machine_service.freeze_time(fake_time)
      response = {"time" => fake_time}

      [HTTP::Status::CREATED, HEADER_CONTENT_TYPE_JSON, response.to_json]
    rescue InvalidIso8601DatetimeFormatError => ex
      [HTTP::Status::BAD_REQUEST, ex.messages]
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