class Api::V1::RoadTripsController < ApplicationController
  def show
    if User.api_key?(params[:api_key])
      geocoding_response = GoogleGeocodingService.new(params[:destination])
      coords = geocoding_response.get_coords[:results].first[:geometry][:location]
      
      directions_response = GoogleDirectionsService.new(params[:origin], params[:destination])
      travel_time = directions_response.get_distance[:routes].first[:legs].first[:duration][:text]
      
      hours = travel_time.split(" ").first.to_i+1
      
      forecast = OpenWeatherService.new(coords[:lat], coords[:lng])
      weather = {
        temp: forecast.get_weather_data[:hourly][hours-1][:temp],
        weather: forecast.get_weather_data[:hourly][hours-1][:weather].first[:description]
      }
      
      road_trip = RoadTrip.new(params[:origin], params[:destination], travel_time, weather)
      render json: RoadTripSerializer.new(road_trip)
    else
      # 401
    end
  end
end
