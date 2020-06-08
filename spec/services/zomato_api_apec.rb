require 'rails_helper'

describe "Zomato API" do
  it "returns expected response", :vcr do
    response = ZomatoService.new('italian', 'denver,co')
    expected = ""

    expect(response).to eq(expected)
  end
end
