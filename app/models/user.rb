class User < ApplicationRecord
  def self.find_user(email, password)
    User.where(email: "#{email}", password: "#{password}").first
  end
end
