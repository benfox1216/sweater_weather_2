class GoogleDirectionsService
  attr_reader
  
  def initialize()
  end
  
  def get_coords
    JSON.parse(response.body, symbolize_names: true)
  end

  private
  
  def response
    uri = "maps/api/directions/outputFormat?parameters"
    Faraday.get("http://maps.googleapis.com/#{uri}")
  end
end
