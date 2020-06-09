require 'rails_helper'

describe "Trails API" do
  it "returns required attributes & trails information" do
    get '/api/v1/trails?location=denver,co'
    expect(response).to be_successful
    
    json = JSON.parse(response.body, symbolize_names: true)
    
    expected = {
      name: "Boulder Skyline Traverse",
      summary: "The classic long mountain route in Boulder.",
      difficulty: "black",
      location: "Superior, Colorado",
      distance_to_trail: 23.008
    }
    
    expect(json[:data][:attributes][:location]).to eq("denver,co")
    expect(json[:data][:attributes][:forecast].class).to eq(Hash)
    expect(json[:data][:attributes][:trails].count).to eq(10)
    expect(json[:data][:attributes][:trails].first).to eq(expected)
  end
end
