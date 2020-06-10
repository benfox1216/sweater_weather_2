class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(permit_params)
    user.api_key = SecureRandom.hex
    
    if params[:password] != params[:password_confirmation]
      render json: {error: "Passwords do not match", status: 400},
        status: 400
    elsif User.email_taken?(params[:email])
      render json: {error: "Email is taken", status: 400},
        status: 400
    elsif user.save
      render json: UsersSerializer.new(user), status: :created
    else
      #
    end
  end
  
  private
  
  def permit_params
    params.permit(:email, :password, :password_confirmation)
  end
end
