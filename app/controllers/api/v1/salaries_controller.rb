class Api::V1::SalariesController < ApplicationController
  def salaries
    if params[:destination] && params[:destination].present?
      location = params[:destination] if params[:destination].present?
      info = SalariesFacade.city_job_weather_info(location)
      @serial = SalariesSerializer.new(info)
      render json: @serial
    else
      param_invalid('destination', 'cannot be empty/blank')
    end
  end
end
