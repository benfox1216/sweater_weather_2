class UnsplashService
  attr_reader :city
  
  def initialize(city)
    @city = city
  end
  
  def get_background_pic
    JSON.parse(response.body, symbolize_names: true)
  end

  private
  
  def response
    conn.get("search/photos?") do |r|
      r.headers[:content_type] = 'application/json'
      r.params[:page] = 1
      r.params[:per_page] = 1
      r.params[:query] = "#{@city}"
      r.params[:client_id] = "#{ENV['UNSPLASH_API_KEY']}"
    end
  end
  
  def conn
    Faraday.new("https://api.unsplash.com/")
  end
end
