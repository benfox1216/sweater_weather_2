require 'rails_helper'

describe "Background API" do
  it "returns a picture from the destination city", :vcr do
    get '/api/v1/backgrounds?location=pueblo,co', as: :json

    expect(response.content_type).to eq('application/json')
    expect(response.status).to eq(200)
    expect(response).to be_successful
    
    json = JSON.parse(response.body, symbolize_names: true)
    
    expected = 'https://images.unsplash.com/photo-1591294071573-f0e27629d46c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjE0MDg5N30'
    
    expect(json[:data][:attributes].count).to eq(1)
    expect(json[:data][:attributes][:pic]).to eq(expected)
  end
end
