class Api::V1::BackgroundsController < ApplicationController
  def index
    render json: BackgroundSerializer.new(get_background)
  end
  
  private
  
  def get_background
    response = UnsplashService.new(params[:location])
    info = response.get_background_pic[:results].first[:urls][:raw]
    Background.new(info)
  end
end
