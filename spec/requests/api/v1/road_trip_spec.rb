require 'rails_helper'

describe "Road Trip API" do
  before :each do
    password = SecureRandom.hex(4)
    @key = SecureRandom.hex
    
    user = User.create!(
      email: Faker::Internet.email,
      password: password,
      password_confirmation: password,
      api_key: @key
    )
  end
  
  it "returns the desired info", :vcr do
    headers = {"Accept" => "application/json"}
    
    params = {
      origin: "Denver,CO",
      destination: "Pueblo,CO",
      api_key: @key
    }
    
    post "/api/v1/road_trip", params: params, headers: headers, as: :json
    
    expect(response.content_type).to eq('application/json')
    expect(response.status).to eq(200)
    expect(response).to be_successful
    
    json = JSON.parse(response.body, symbolize_names: true)
    
    expect(json[:data][:attributes].count).to eq(4)
    expect(json[:data][:attributes][:arrival_forecast].count).to eq(2)
    expect(json[:data][:attributes][:travel_time]).to eq("1 hour 48 mins")
  end
  
  it "returns 401 (Unauthorized) error when API key is bad", :vcr do
    headers = {"Accept" => "application/json"}
    
    params = {
      origin: "Denver,CO",
      destination: "Pueblo,CO",
      api_key: "xyz"
    }
    
    post "/api/v1/road_trip", params: params, headers: headers, as: :json
    
    expect(response.content_type).to eq('application/json')
    expect(response.status).to eq(401)
    
    json = JSON.parse(response.body, symbolize_names: true)
    expect(json).to eq({error: "Unauthorized", status: 401})
  end
end
