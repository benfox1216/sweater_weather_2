class Api::V1::TrailsController < ApplicationController
  def show
    coordinates = get_coordinates
    lat = coordinates[:lat]
    lng = coordinates[:lng]
    
    weather = get_weather(lat, lng)
    forecast = format_weather(weather)
    
    trails = get_trails(lat, lng)
    all_trails = format_trails(trails)
    
    hiking_info = Hiking.new(params[:location], forecast, all_trails)
    render json: TrailSerializer.new(hiking_info)
  end
  
  private
  
  def get_coordinates
    google_geocoding_response = GoogleGeocodingService.new(params[:location])
    coordinates = google_geocoding_response.
      get_coords[:results].first[:geometry][:location]
  end
  
  def get_weather(lat, lng)
    open_weather_response = OpenWeatherService.new(lat, lng)
    weather = open_weather_response.get_weather_data[:current]
  end
  
  def format_weather(weather)
    {
      summary: weather[:weather].first[:description],
      temperature: weather[:temp]
    }
  end
  
  def get_trails(lat, lng)
    trails_response = HikingProjectService.new(lat, lng)
    trails = trails_response.get_trails_info[:trails]
  end
  
  def format_trails(trails)
    trails.map do |trail|
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
  end
end
