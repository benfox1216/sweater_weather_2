require 'rails_helper'

describe "Google Directions API" do
  it "returns expected response", :vcr do
    response = GoogleDirectionsService.new('denver,co', 'pueblo,co').get_directions
    expected = "1 hour 48 mins"

    expect(response[:routes].first[:legs].first[:distance][:duration]).to eq(expected)
  end
end
