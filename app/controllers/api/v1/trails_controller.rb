class Api::V1::TrailsController < ApplicationController
  def show
    info = HikingInfo.new(params[:location])
    render json: TrailSerializer.new(info.hiking_info)
  end
end
