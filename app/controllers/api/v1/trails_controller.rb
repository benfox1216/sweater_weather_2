class Api::V1::TrailsController < ApplicationController
  def show
    google_geocoding_response = GoogleGeocodingService.new(params[:location])
    coordinates = google_geocoding_response.
      get_coords[:results].first[:geometry][:location]
      
    lat = coordinates[:lat]
    lng = coordinates[:lng]
    
    open_weather_response = OpenWeatherService.new(lat, lng)
    weather = open_weather_response.get_weather_data[:current]
    
    temp = weather[:temp]
    forecast = weather[:weather].first[:description]
  end
end
