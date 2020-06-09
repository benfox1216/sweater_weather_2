require 'rails_helper'

describe "Forecast API" do
  it "returns the current & 7-day forecast in JSON format", :vcr do
    get '/api/v1/forecast?location=denver,co'

    expect(response.content_type).to eq('application/json')
    expect(response.status).to eq(200)
    expect(response).to be_successful
    
    json = JSON.parse(response.body, symbolize_names: true)
    
    expect(json[:data][:attributes].count).to eq(4)
    expect(json[:data][:attributes][:current].count).to eq(12)
    expect(json[:data][:attributes][:hourly].count).to eq(8)
    expect(json[:data][:attributes][:daily].count).to eq(5)
  end
end
