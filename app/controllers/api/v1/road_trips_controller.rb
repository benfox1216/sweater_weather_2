class Api::V1::RoadTripsController < ApplicationController
  def show
    geocoding_response = GoogleGeocodingService.new(params[:destination])
    coords = geocoding_response.get_coords[:results].first[:geometry][:location]
    
    directions_response = GoogleDirectionsService.new(params[:origin], params[:destination])
    distance = directions_response.get_distance
    binding.pry
    
    
    forecast = OpenWeatherService.new(coords[:lat], coords[:lng])
    info = forecast.get_weather_data
  end
end
