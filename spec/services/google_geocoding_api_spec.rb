require 'rails_helper'

describe "Google Directions API" do
  it "returns expected response", :vcr do
    response = GoogleDirectionsService.new('denver,co')
    # expected = ?

    expect().to eq(expected)
  end
end
