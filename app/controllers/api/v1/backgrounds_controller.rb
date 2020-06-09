class Api::V1::BackgroundsController < ApplicationController
  def index
    response = UnsplashService.new(params[:location])
    pic = response.get_background_pic[:results].first[:urls][:raw]
    background_object = Background.new(pic)
    render json: BackgroundSerializer.new(background_object)
  end
end
