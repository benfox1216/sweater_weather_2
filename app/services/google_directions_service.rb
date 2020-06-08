class GoogleDirectionsService
  attr_reader :something
  
  def initialize(orig_city_state, dest_city_state)
    @orig_city = orig_city_state.split(',').first
    @orig_state = orig_city_state.split(',').last
    @dest_city = dest_city_state.split(',').first
    @dest_state = dest_city_state.split(',').last
  end
  
  def get_directions
    JSON.parse(response.body, symbolize_names: true)
  end

  private
  
  def response
    uri = "maps/api/directions/json?origin=#{@orig_city}+#{@orig_state}&destination=#{@dest_city}+#{@dest_state}&key=#{ENV['GOOGLE_API_KEY']}"
    Faraday.get("https://maps.googleapis.com/#{uri}")
  end
end
