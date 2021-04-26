class Api::V1::RoadTripController < ApplicationController
include ApiKeyAuthenticatable
prepend_before_action :authenticate_with_api_key!, only: [:index]
# Optional token authentication for logout
# prepend_before_action :authenticate_with_api_key, only: [:destroy]

    def index
        
        from = params[:origin] if params[:origin].present?
        to = params[:destination] if params[:destination].present?
        @road_trip = RoadTripFacade.road_trip(from, to)
        @serial = RoadtripSerializer.new(@road_trip)
        
        render json: @serial
        
        # RoadtripFacade.roadtrips(origin, destination)
        # render json: {data: 'success'}
    end
    

end
