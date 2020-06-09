class GoogleDirectionsService
  attr_reader :city_state
  
  def initialize(origin, destination)
    @origin = "#{origin.split(',').first}+#{origin.split(',').last}"
    @destination = "#{destination.split(',').first}+#{destination.split(',').last}"
  end
  
  def get_distance
    JSON.parse(response.body, symbolize_names: true)
  end

  private
  
  def response
    conn.get("maps/api/directions/json?") do |r|
      r.headers[:content_type] = 'application/json'
      r.params[:origin] = "#{@origin}"
      r.params[:destination] = "#{@destination}"
      r.params[:key] = "#{ENV['GOOGLE_API_KEY']}"
    end
  end
  
  def conn
    Faraday.new("https://maps.googleapis.com/")
  end
end
