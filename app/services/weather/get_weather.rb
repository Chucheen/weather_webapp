require 'net/http'

class Weather::GetWeather < ApplicationInteractor
  CONTRACT_CLASS = Weather::ResultContract
  WEATHER_API_URL = 'https://api.openweathermap.org/data/2.5/weather'
  before :validate_contract!

  def call
    context.response = JSON.parse(get_weather_report)
    context.fail!(error: [to_error(context.response["message"], :bad_request)]) if context.response["cod"].to_i != 200
  rescue ::Errors::Base => e
    handle_error(e)
  end

  def get_weather_report
    uri = URI.parse(WEATHER_API_URL)
    params = URI.encode_www_form({appid: ENV['OPEN_WEATHER_API_KEY']}.merge(queries))
    uri.query = params

    puts uri
    Net::HTTP.get(uri)
  end

  def queries
    case context.params.to_h

    in {lat: lat, lon: lon, city_name: "" }
      {lat: lat, lon: lon}
    in {lat: "" , lon: "", city_name: city_name}
      {q: city_name}
    end
  end
end
