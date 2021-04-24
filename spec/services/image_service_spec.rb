require 'rails_helper'

RSpec.describe WeatherService, type: :model do
    describe "Testing class method" do
        it "get_image_id", :vcr do
            @id = ImagesService.get_image_id('denver,co')
            expect(@id.class).to eq(String)
            expect(@id.to_i > 0).to eq(true)
        end

        it "get_image", :vcr do
            response = ImagesService.get_image('denver,co')
            expect(response.class).to eq(Hash)
            
        end
    end
end