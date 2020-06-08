class ZomatoService
  attr_reader :cuisine, :lat_long
  
  def initialize(cuisine, city_state)
    @cuisine = cuisine
    @lat_long = GoogleGeocodingService.new(city_state)
  end
  
  def get_restaurant_info
    binding.pry
    parse(get_city_id)
  end

  private
  
  def get_city_id
    uri = "/api/v2.1/cities?lat=#{lat_long[:lat]}&lon=#{lat_long[:long]}&count=1"
    Faraday.get("https://developers.zomato.com/#{uri}")
  end
  
  def get_cuisine_id
    
  end
  
  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
  
  def response_1
    uri = "maps/api/directions/json?origin=#{@orig_city}+#{@orig_state}&destination=#{@dest_city}+#{@dest_state}&key=#{ENV['GOOGLE_API_KEY']}"
    Faraday.get("https://developers.zomato.com/#{uri}")
  end
  
  def response_2
    'api/v2.1/cities?lat=38.2544&lon=-104.6091&count=1'
  end
  
  def response_3
    
  end
end
