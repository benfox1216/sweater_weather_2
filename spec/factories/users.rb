require 'securerandom'

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Name.last_name }
    password_confirmation { SecureRandom.hex(4) }
    api_key { SecureRandom.hex }
  end
end
