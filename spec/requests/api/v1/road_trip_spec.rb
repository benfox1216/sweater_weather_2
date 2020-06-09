require 'rails_helper'

describe "Road Trip API" do
  it "returns the desired info", :vcr do
    password = SecureRandom.hex(4)
    key = SecureRandom.hex
    
    user = User.create!(
      email: Faker::Internet.email,
      password: password,
      password_confirmation: password,
      api_key: key
    )
    
    headers = {"Accept" => "application/json"}
    
    params = {
      origin: "Denver,CO",
      destination: "Pueblo,CO",
      api_key: key
    }
    
    post "/api/v1/road_trip", params: params, headers: headers
    
    expect(response.content_type).to eq('application/json')
    expect(response.status).to eq(200)
    expect(response).to be_successful
    
    json = JSON.parse(response.body, symbolize_names: true)
    
    expect(json[:data][:attributes].count).to eq(4)
    expect(json[:data][:attributes][:arrival_forecast].count).to eq(2)
    expect(json[:data][:attributes][:travel_time]).to eq("1 hour 48 mins")
  end
end
