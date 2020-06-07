require 'rails_helper'

describe "Google Geocoding API" do
  
  it "returns expected response", :vcr do
    response = GoogleGeocodingService.new('Denver, CO')
    expected = {
       "lat": 39.7392358,
       "lng": -104.990251
    }

    expect(response.get_coords[:results].first[:geometry][:location]).to eq(expected)
  end
end
