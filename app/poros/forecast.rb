class Forecast
  attr_reader :id, :current, :hourly, :daily
  
  def initialize(info, location)
    @id =  nil
    @current = {
      location: location,
      date_time: Time.now.strftime('%I:%M %p, %m/%d'),
      weather: info[:current][:weather].first[:description],
      current_temp: info[:current][:temp],
      high: info[:daily].first[:temp][:max],
      low: info[:daily].first[:temp][:min],
      feels_like: info[:current][:feels_like],
      humidity: info[:current][:humidity],
      visibility: info[:current][:visibility],
      uv_index: info[:current][:uvi],
      sunrise: info[:current][:sunrise],
      sunset: info[:current][:sunset]
    }
    
    @hourly = {
      current_hour: {temp: info[:hourly].first[:temp]},
      one_hour: {temp: info[:hourly][1][:temp]},
      two_hours: {temp: info[:hourly][2][:temp]},
      three_hours: {temp: info[:hourly][3][:temp]},
      four_hours: {temp: info[:hourly][4][:temp]},
      five_hours: {temp: info[:hourly][5][:temp]},
      six_hours: {temp: info[:hourly][7][:temp]},
      seven_hours: {temp: info[:hourly][8][:temp]}
    }
    
    @daily = {
      today: {
        weather: info[:daily].first[:weather].first[:main],
        rain: info[:daily].first[:rain],
        high: info[:daily].first[:temp][:max],
        low: info[:daily].first[:temp][:min]
      },
      tomorrow: {
        weather: info[:daily][1][:weather].first[:main],
        rain: info[:daily][1][:rain],
        high: info[:daily][1][:temp][:max],
        low: info[:daily][1][:temp][:min]
      },
      two_days: {
        weather: info[:daily][2][:weather].first[:main],
        rain: info[:daily][2][:rain],
        high: info[:daily][2][:temp][:max],
        low: info[:daily][2][:temp][:min]
      },
      three_days: {
        weather: info[:daily][3][:weather].first[:main],
        rain: info[:daily][3][:rain],
        high: info[:daily][3][:temp][:max],
        low: info[:daily][3][:temp][:min]
      },
      four_days: {
        weather: info[:daily][4][:weather].first[:main],
        rain: info[:daily][4][:rain],
        high: info[:daily][4][:temp][:max],
        low: info[:daily][4][:temp][:min]
      }
    }
  end
end
