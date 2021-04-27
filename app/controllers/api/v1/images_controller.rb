class Api::V1::ImagesController < ApplicationController
  before_action :check_params
  def backgrounds
    @image = ImagesFacade.get_image(params[:location])
    if @image.class == Array
      return bad_request(@image)
    else
      render json: ImageSerializer.new(@image)
    end
  end

  private

  def check_params
    if params[:location].nil?
      return [false, param_missing(['location'])]
    end
    
    if params[:location] && params[:location].length < 1
      return [false, param_bad('location', 'cannot be empty/blank')]
    end
  end
end
