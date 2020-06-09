class HikingProjectService
  attr_reader :destination
  
  def initialize(lat, lng)
    @lat = lat
    @lng = lng
  end
  
  def get_trails_info
    JSON.parse(response.body, symbolize_names: true)
  end
  
  private
  
  def response
    conn.get("data/get-trails?") do |r|
      r.params[:key] = "#{ENV['HIKING_API_KEY']}"
      r.params[:lat] = "#{@lat}"
      r.params[:lon] = "#{@lng}"
    end
  end
  
  def conn
    Faraday.new("https://www.hikingproject.com/")
  end
end
