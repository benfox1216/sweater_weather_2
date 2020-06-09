class Hiking
  attr_reader :id, :location, :forecast, :trails
  
  def initialize(location, forecast, trails)
    @id = nil
    @location = location
    @forecast = forecast
    @trails = trails
  end
end
