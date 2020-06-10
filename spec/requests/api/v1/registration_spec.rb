require 'rails_helper'

describe "Registration API" do
  before :each do
    @password = SecureRandom.hex(4)
    @headers = {"Accept" => "application/json"}
  end
  
  it "creates a user, returns correct data" do
    params = {
      email: Faker::Internet.email,
      password: @password,
      password_confirmation: @password
    }
    
    post "/api/v1/users", params: params, headers: @headers, as: :json

    expect(response.content_type).to eq('application/json')
    expect(response.status).to eq(201)
    expect(response).to be_successful
    
    json = JSON.parse(response.body, symbolize_names: true)
    
    expect(json[:data][:attributes][:email]).to eq(User.last.email)
    expect(json[:data][:attributes][:api_key]).to eq(User.last.api_key)
  end
  
  it "returns correct error when passwords do not match" do
    params = {
      email: Faker::Internet.email,
      password: @password,
      password_confirmation: "xyz"
    }
    
    post "/api/v1/users", params: params, headers: @headers, as: :json

    expect(response.content_type).to eq('application/json')
    expect(response.status).to eq(400)
    
    json = JSON.parse(response.body, symbolize_names: true)
    expect(json).to eq({error: "Passwords do not match", status: 400})
  end
  
  it "returns correct error when email is taken" do
    user = User.create!(
      email: Faker::Internet.email,
      password: @password,
      password_confirmation: @password,
      api_key: SecureRandom.hex
    )
    
    params = {
      email: user.email,
      password: @password,
      password_confirmation: @password
    }
    
    post "/api/v1/users", params: params, headers: @headers, as: :json

    expect(response.content_type).to eq('application/json')
    expect(response.status).to eq(400)
    
    json = JSON.parse(response.body, symbolize_names: true)
    expect(json).to eq({error: "Email is taken", status: 400})
  end
  
  it "returns correct error when there is a missing field" do
    
  end
end
