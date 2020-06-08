class Api::V1::ForecastController < ApplicationController
  def index
    response = GoogleGeocodingService.new(params[:location])
    coords = response.get_coords[:results].first[:geometry][:location]
    forecast = OpenWeatherService.new(coords[:lat], coords[:lng])
    info = forecast.get_weather_data
    necessary_info = Forecast.new(info, params[:location])
    render json: ForecastSerializer.new(necessary_info)
  end
end
