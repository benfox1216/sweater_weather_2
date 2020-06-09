require 'rails_helper'

describe "Unsplash API", :vcr do
  it "returns expected response" do
    response = UnsplashService.new('pueblo')
    expected = 'https://images.unsplash.com/photo-1591294071573-f0e27629d46c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjE0MDg5N30'
    expect(response.get_background_pic[:results].first[:urls][:raw]).to eq(expected)
  end
end
