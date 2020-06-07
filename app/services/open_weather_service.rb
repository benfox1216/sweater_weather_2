class OpenWeatherService
  attr_reader :lat, :long
  
  def initialize(lat, long)
    @lat = lat
    @long = long
  end
  
  def get_weather_data
    JSON.parse(response.body, symbolize_names: true)
  end

  private
  
  def response
    uri = "data/2.5/onecall?lat=#{@lat}&lon=#{@long}&appid=#{ENV['OPENWEATHER_API_KEY']}"
    Faraday.get("https://api.openweathermap.org/#{uri}")
  end
end
