require 'rails_helper'

describe "Google Directions API" do
  it "returns expected response", :vcr do
    response = GoogleDirectionsService.new('denver,co', 'pueblo,co')
    expected = "1 hour 48 mins"

    expect(response.get_distance[:routes].first[:legs]
      .first[:duration][:text]).to eq(expected)
  end
end
