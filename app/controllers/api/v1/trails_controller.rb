class Api::V1::TrailsController < ApplicationController
  def show
    
    
    open_weather_response = OpenWeatherService.new
    
    binding.pry
  end
end
