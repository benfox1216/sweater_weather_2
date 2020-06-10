class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(permit_params)
    user.api_key = SecureRandom.hex
    
    if User.email_taken?(params[:email])
      render json: {error: "Email is taken", status: 400},
        status: 400
    elsif params[:password] != params[:password_confirmation]
      render json: {error: "Passwords do not match, or a field was left empty",
        status: 400}, status: 400
    else user.save
      render json: UsersSerializer.new(user), status: :created
    end
  end
  
  private
  
  def permit_params
    params.permit(:email, :password, :password_confirmation)
  end
end
