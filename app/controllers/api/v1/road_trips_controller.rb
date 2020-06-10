class Api::V1::RoadTripsController < ApplicationController
  def show
    if User.api_key?(params[:api_key])
      road_trip = TripData.new(params)
      render json: RoadTripSerializer.new(road_trip.get_data)
    else
      render json: {error: "Unauthorized", status: 401}, status: 401
    end
  end
end
