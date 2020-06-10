class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true
  
  def self.find_user(email, password)
    where(email: "#{email}", password: "#{password}").first
  end
  
  def self.api_key?(api_key)
    return true if where(api_key: api_key) != []
    false
  end
  
  def self.email_taken?(email)
    return true if where(email: email) != []
    false
  end
end
