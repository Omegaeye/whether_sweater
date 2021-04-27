require 'rails_helper'

RSpec.describe WeatherFacade, type: :model do

  describe "class methods" do
    it "get_image", :vcr do
        response = ImagesFacade.get_image('denver,co')
        expect(response.class).to eq(OpenStruct)
        expect(response.image.keys).to eq(%i[location image_url credit])
    end
  end
end