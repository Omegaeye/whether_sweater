class Api::V1::ImagesController < ApplicationController
  before_action :check_params_location
  def backgrounds
    @image = ImagesFacade.get_image(params[:location])
    if @image.class == Array
      return bad_request(@image)
    else
      render json: ImageSerializer.new(@image)
    end
  end

  private


end
