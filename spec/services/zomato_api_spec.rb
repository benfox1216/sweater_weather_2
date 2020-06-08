require 'rails_helper'

describe "Zomato API" do
  it "returns expected response", :vcr do
    response = ZomatoService.new('italian', 'pueblo,co').get_restaurant_info
    expected = ""

    expect(response).to eq(expected)
  end
end
