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
    
    trails_response = HikingProjectService.new(lat, lng)
    trails = trails_response.get_trails_info[:trails]
    
    all_trails = trails.map do |trail|
      mapquest_response = MapquestService.new(params[:location], trail[:location])
      distance = mapquest_response.get_distance[:route][:distance]
      
      {
        name: trail[:name],
        summary: trail[:summary],
        difficulty: trail[:difficulty],
        location: trail[:location],
        distance_to_trail: distance
      }
    end
    
    binding.pry
  end
end
