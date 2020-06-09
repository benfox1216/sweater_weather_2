require 'securerandom'

class Api::V1::SessionsController < ApplicationController
  def show
    user = User.find_user(params[:email], params[:password])
    
    if user.class == User
      render json: UsersSerializer.new(user)
    else
      #
    end
  end
end
