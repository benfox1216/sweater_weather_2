require 'rails_helper'

describe "OpenWeather API", :vcr do
  it "returns expected response" do
    response = OpenweatherService.new(39.7392358, -104.990251)
    expect(response.get_weather_data[:timezone]).to eq("America/Denver")
  end
end
