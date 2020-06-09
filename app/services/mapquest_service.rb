class MapquestService
  attr_reader :origin, :destination
  
  def initialize(origin, destination)
    @origin = origin
    @destination = destination
  end
  
  def get_distance
    JSON.parse(response.body, symbolize_names: true)
  end
  
  private
  
  def response
    conn.get("directions/v2/route?") do |r|
      r.params[:key] = "#{ENV['MAPQUEST_API_KEY']}"
      r.params[:from] = "#{@origin}"
      r.params[:to] = "#{@destination}"
    end
  end
  
  def conn
    Faraday.new("http://www.mapquestapi.com/")
  end
end
