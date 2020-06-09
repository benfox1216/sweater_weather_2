class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(permit_params)
    user.api_key = SecureRandom.hex
    
    if user.save
      render json: UsersSerializer.new(user), status: :created
    else
      # render :json {error: "passwords don't match"}, status: :bad_request
    end
  end
  
  private
  
  def permit_params
    params.permit(:email, :password, :password_confirmation)
  end
end
