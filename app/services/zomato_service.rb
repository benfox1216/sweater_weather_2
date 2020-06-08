class ZomatoService
  attr_reader :cuisine, :lat_long
  
  def initialize(cuisine, city_state)
    @cuisine = cuisine
    @lat_long = GoogleGeocodingService.new(city_state).get_coords[:results].first[:geometry][:location]
  end
  
  def get_restaurant_info
    city_id = parse(get_city_id)[:location_suggestions]
    cuisine_id = parse(get_cuisine_id(city_id))
    binding.pry
  end

  private
  
  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
  
  def get_city_id
    uri = "api/v2.1/search?lat=#{@lat_long[:lat]}&lon=#{@lat_long[:long]}&count=1&user-key=#{ENV['ZOMATO_API_KEY']}"
    Faraday.get("https://developers.zomato.com/#{uri}")
  end
  
  def get_cuisine_id(id)
    uri = "api/v2.1/cuisines?city_id=#{id}&user-key=#{ENV['ZOMATO_API_KEY']}"
    Faraday.get("https://developers.zomato.com/#{uri}")
  end
end
