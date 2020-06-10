class Api::V1::ForecastController < ApplicationController
  def index
    render json: ForecastSerializer.new(get_forecast)
  end
  
  private
  
  def get_forecast
    coords = get_coords
    forecast = OpenWeatherService.new(coords[:lat], coords[:lng])
    info = forecast.get_weather_data
    Forecast.new(info, params[:location])
  end
  
  def get_coords
    response = GoogleGeocodingService.new(params[:location])
    response.get_coords[:results].first[:geometry][:location]
  end
end
