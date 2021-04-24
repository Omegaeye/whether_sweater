class Api::V1::ImagesController < ApplicationController

    def backgrounds
        if params[:location].present?
            @image = ImagesFacade.get_image(params[:location])
            render json: ImageSerializer.new(@image)
        else
            render json: {data: {}}, status: 404
        end
    end
    

end
