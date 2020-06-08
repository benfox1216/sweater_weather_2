class GoogleGeocodingService
  attr_reader :city_state
  
  def initialize(city_state)
    @city = city_state.split(',').first
    @state = city_state.split(',').last
  end
  
  def get_coords
    JSON.parse(response.body, symbolize_names: true)
  end

  private
  
  def response
    conn.get("maps/api/geocode/json?") do |r|
      r.headers[:content_type] = 'application/json'
      r.params[:address] = "#{@city},+#{@state}"
      r.params[:key] = "#{ENV['GOOGLE_API_KEY']}"
    end
  end
  
  def conn
    Faraday.new("https://maps.googleapis.com/")
  end
end
