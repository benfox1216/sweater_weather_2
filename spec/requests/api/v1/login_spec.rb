require 'rails_helper'

describe "Login API" do
  it "finds a user, returns correct data" do
    password = SecureRandom.hex(4)
    
    user = User.create!(
      email: Faker::Internet.email,
      password: password,
      password_confirmation: password,
      api_key: SecureRandom.hex
    )
    
    headers = {"Accept" => "application/json"}
    
    params = {
      email: "#{user.email}",
      password: "#{user.password}"
    }
    
    post "/api/v1/sessions", params: params, headers: headers, as: :json

    expect(response.content_type).to eq('application/json')
    expect(response.status).to eq(200)
    expect(response).to be_successful
    
    json = JSON.parse(response.body, symbolize_names: true)
    
    expect(json[:data][:attributes][:email]).to eq("#{user.email}")
    expect(json[:data][:attributes][:api_key]).to eq("#{user.api_key}")
  end
end
