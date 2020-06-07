require 'rails_helper'

describe "Google Geocoding API" do
  
  it "returns expected response", :vcr do
    response = GoogleGeocodingService.new
    coords = response.get_coords('Denver, CO')
    
    expected = {
       "lat": 39.7392358,
       "lng": -104.990251
    }

    expect(coords[:results].first[:geometry][:location]).to eq(expected)
  end
end
