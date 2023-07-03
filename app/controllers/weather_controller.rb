class WeatherController < ApplicationController
  def index; end

  def result
    context = Weather::GetWeather.call(params: permitted_params)

    handle_error(context) and return if context.failure?

    @weather_info = context.response
  end

  def handle_error(context)
    errors_str = context.error.map { "<b>#{_1[:source]}:</b> #{_1[:detail]}" }.join('<br>')
    flash[:error] = errors_str

    redirect_to root_path
  end

  def permitted_params
    params.permit(:lat, :lon, :city_name)
  end
end