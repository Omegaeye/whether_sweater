require 'rails_helper'

RSpec.describe WeatherService, type: :model do
    describe "Testing class method" do
        it "get_forecast", :vcr do
            response = WeatherService.get_forecast(-105.016, 39.612)
            expect(response.class).to eq(Hash)
        end
    end
end