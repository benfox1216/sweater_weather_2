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
    conn.get("data/2.5/onecall?") do |r|
      r.headers[:content_type] = 'application/json'
      r.params[:lat] = "#{@lat}"
      r.params[:lon] = "#{@long}"
      r.params[:units] = 'imperial'
      r.params[:appid] = "#{ENV['OPENWEATHER_API_KEY']}"
    end
  end
  
  def conn
    Faraday.new("https://api.openweathermap.org/")
  end
end
