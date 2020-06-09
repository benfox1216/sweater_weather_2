require 'rails_helper'

describe "Registration API" do
  it "creates a user, returns correct data" do
    headers = {"Accept" => "application/json"}
    
    params = {
      email: "whatever@example.com",
      password: "password",
      password_confirmation: "password"
    }
    
    post "/api/v1/users", params: params, headers: headers

    expect(response.content_type).to eq('application/json')
    expect(response.status).to eq(201)
    expect(response).to be_successful
    
    json = JSON.parse(response.body, symbolize_names: true)
    
    expect(json[:data][:attributes][:email]).to eq("whatever@example.com")
    expect(json[:data][:attributes][:api_key]).to eq(User.last.api_key)
  end
end
