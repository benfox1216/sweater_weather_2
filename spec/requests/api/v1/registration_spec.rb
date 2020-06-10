require 'rails_helper'

describe "Registration API" do
  it "creates a user, returns correct data" do
    random = SecureRandom.hex(4)
    
    headers = {"Accept" => "application/json"}
    
    params = {
      email: Faker::Internet.email,
      password: random,
      password_confirmation: random,
    }
    
    post "/api/v1/users", params: params, headers: headers, as: :json

    expect(response.content_type).to eq('application/json')
    expect(response.status).to eq(201)
    expect(response).to be_successful
    
    json = JSON.parse(response.body, symbolize_names: true)
    
    expect(json[:data][:attributes][:email]).to eq(User.last.email)
    expect(json[:data][:attributes][:api_key]).to eq(User.last.api_key)
  end
end
