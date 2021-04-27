require 'rails_helper'

RSpec.describe RoadTripFacade, type: :model do

    describe "class methods" do
        it "road_trip", :vcr do
            response = RoadTripFacade.road_trip('chicago,il', 'denver,co')
            expect(response.class).to eq(OpenStruct)
            expect(response.start_city.present?).to eq(true)
            expect(response.end_city.present?).to eq(true)
            expect(response.travel_time.present?).to eq(true)
            expect(response.weather_at_eta.present?).to eq(true)
        end
    end
end
