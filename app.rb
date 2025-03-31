require 'sinatra'
require 'httparty'
require 'dotenv/load'

get '/' do
  erb :index
end

post '/weather' do
  city = params[:city]
  api_key = ENV['OPENWEATHER_API_KEY']

  response = HTTParty.get("https://api.openweathermap.org/data/2.5/weather?q=#{city}&appid=#{api_key}&units=metric")

  if response.code == 200
    @weather = response.parsed_response
    @city = city
  else
    @error = "Could not find weather for #{city}"
  end

  erb :index
end
