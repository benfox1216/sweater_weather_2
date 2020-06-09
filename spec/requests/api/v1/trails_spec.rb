require 'rails_helper'

describe "Trails API" do
  it "returns required attributes & trails information" do
    get '/api/v1/trails?location=denver,co'
    expect(response).to be_successful
    
    json = JSON.parse(response.body, symbolize_names: true)
    expect(json).to eq("")
  end
end
