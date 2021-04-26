class Api::V1::SalariesController < ApplicationController

    def salaries
        location = params[:destination] if params[:destination].present?
        info = CityFacade.city_job_weather_info(location)
        @serial = SalariesSerializer.new(info)
        render json: @serial
    end
    
end
