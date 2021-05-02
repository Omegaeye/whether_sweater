require 'rails_helper'

RSpec.describe RoadTripFacade, type: :model do

    describe "class methods" do
        context "roat_trip" do
            it "it should return OpenStruct with attributes", :vcr do
                response = RoadTripFacade.road_trip('chicago,il', 'denver,co')
                expect(response.class).to eq(OpenStruct)
                expect(response.start_city.present?).to eq(true)
                expect(response.end_city.present?).to eq(true)
                expect(response.travel_time.present?).to eq(true)
                expect(response.weather_at_eta.present?).to eq(true)
            end
        end
        
        context "direction" do
            it "should return Hash with 3 keys", :vcr do
               response = RoadTripFacade.direction('chicago,il', 'denver,co')
               expect(response.class).to eq(Hash)
               expect(response[:travel_time].present?).to eq(true)
               expect(response[:lon].present?).to eq(true)
               expect(response[:lat].present?).to eq(true)
           end
        end

         context "eta weather" do
            it "should return Hash with summary and temperature", :vcr do
                weather = RoadTripFacade.direction('chicago,il', 'denver,co')
                response = RoadTripFacade.eta_weather(weather[:lon], weather[:lat], weather[:dt])
                expect(response.class).to eq(Hash)   
                expect(response[:temperature].present?).to eq(true)
                expect(response[:summary].present?).to eq(true)
            end             
         end

         context "daily weather info" do
            it "should return Hash with daily summary & temperature", :vcr do
                weather = RoadTripFacade.direction('chicago,il', 'denver,co')
                response = RoadTripFacade.daily_weather_info(weather[:lon], weather[:lat], weather[:dt])
                expect(response.class).to eq(Hash)   
                expect(response[:temperature].present?).to eq(true)
                expect(response[:summary].present?).to eq(true)
            end             
         end

         context "hourly weather info" do
            it "should return Hash with hourly summary & temperature", :vcr do
                weather = RoadTripFacade.direction('chicago,il', 'denver,co')
                response = RoadTripFacade.hourly_weather_info(weather[:lon], weather[:lat], weather[:dt])
                expect(response.class).to eq(Hash)   
                expect(response[:temperature].present?).to eq(true)
                expect(response[:summary].present?).to eq(true)
            end             
         end
    end
end
