class GoogleGeocodingService
  attr_reader :city_state
  
  def initialize(city_state)
    @city = city_state.split(', ').first
    @state = city_state.split(', ').last
  end
  
  def get_coords
    JSON.parse(response.body, symbolize_names: true)
  end

  private
  
  def response
    uri = "maps/api/geocode/json?address=#{@city},+#{@state}&key=#{ENV['GOOGLE_API_KEY']}"
    Faraday.get("https://maps.googleapis.com/#{uri}")
  end
end
