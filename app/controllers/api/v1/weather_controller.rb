class Api::V1::WeatherController < ApplicationController
  before_action :check_params_location
  def forecast
    @forecast = WeatherFacade.get_forecast(params[:location])
    if @forecast.class == Array
      return bad_request(@forecast)
    else
      render json: ForecastSerializer.new(@forecast)
    end
  end
end
