class TripData
  attr_reader :params
  
  def initialize(params)
    @params = params
  end
  
  def get_data
    @coords = get_coords
    @travel_time = get_travel_time
    RoadTrip.new(@params[:origin], @params[:destination], @travel_time, get_weather)
  end
  
  private
  
  def get_coords
    geocoding_response = GoogleGeocodingService.new(@params[:destination])
    geocoding_response.get_coords[:results].first[:geometry][:location]
  end
  
  def get_travel_time
    directions_response = GoogleDirectionsService.new(@params[:origin], @params[:destination])
    directions_response.get_distance[:routes].first[:legs].first[:duration][:text]
  end
  
  def get_weather
    hours = @travel_time.split(" ").first.to_i+1
    forecast = OpenWeatherService.new(@coords[:lat], @coords[:lng])
    {
      temp: forecast.get_weather_data[:hourly][hours-1][:temp],
      weather: forecast.get_weather_data[:hourly][hours-1][:weather].first[:description]
    }
  end
end
