class User < ApplicationRecord
  def self.find_user(email, password)
    User.where(email: "#{email}", password: "#{password}").first
  end
  
  def self.api_key?(api_key)
    return true if User.where(api_key: api_key)
    false
  end
end
