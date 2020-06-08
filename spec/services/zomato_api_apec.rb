require 'rails_helper'

describe "Zomato API" do
  it "returns expected response", :vcr do
    response = ZomatoService.new('denver,co', 'pueblo,co').something
    expected = ""

    expect(response).to eq(expected)
  end
end
