class Api::V1::WeatherController < ApplicationController

    def forecast
        if params[:location].present?
            @forecast = WeatherFacade.get_forecast(params[:location])
            render json: ForecastSerializer.new(@forecast)
        else
            render json: {data: {}}, status: 404
        end
    end  
    
end
