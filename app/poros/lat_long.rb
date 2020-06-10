class LatLong
  attr_accessor :lat, :long, :id
  
  def initialize(lat, long)
    @id =  nil
    @lat = lat
    @long = long
  end
end
