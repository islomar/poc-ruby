class Clock
  attr_accessor :datetime

  def initialize(datetime = DateTime.new)
    @datetime = datetime
  end

  def now
    datetime || datetime.now
  end

end

class TimeMachineService

  attr_accessor :fake_time

  def initialize(datetime = DateTime.new)
    @datetime = datetime
  end

  def now
    fake_time || datetime.now
  end

  def freeze_time(fake_time)
    fake_time = fake_time
  end

end
require 'sinatra'


class TimeMachineAPI < Sinatra::Base
  HEADER_CONTENT_TYPE_JSON = { "Content-Type" => "application/json" }

  attr_accessor :fake_time

  get '/hello_world' do
    'hello world'
  end

  get '/time' do
    now = DateTime.new.iso8601
    puts ">>>>>>>>>>>>>> GET #{fake_time}"
    puts self
    puts @fake_time
    puts fake_time
    [200, HEADER_CONTENT_TYPE_JSON, now.to_json]
  end

  post '/time/:data' do
    now = DateTime.new.iso8601
    @fake_time = params[:data]
    puts ">>>>>>>>>>>>>> POST #{fake_time}"
    puts self
    puts @fake_time
    [201, HEADER_CONTENT_TYPE_JSON, now.to_json]
  end
end
