require 'rails_helper'

RSpec.describe WeatherFacade, type: :model do

  describe "class methods" do
    describe "get forecast" do
        before :each do
            @coord = MapQuestService.get_lon_and_lat('littleton,co')
            @forecast = WeatherService.get_forecast(@coord[:lng], @coord[:lat])
        end
        it "returns with current daily and hourly weather", :vcr do
            response = WeatherFacade.get_forecast('littleton,co')
             expect(response.class).to eq(OpenStruct)
        end

        it "get_current_weather", :vcr do
            response = WeatherFacade.get_current_weather(@forecast)
            expect(response.class).to eq(Hash)
            expect(response.keys.size).to eq(10)
            expect(response.keys.size).to_not eq(11)
            expect(response.keys).to eq(%i[datetime sunrise sunset temp feels_like humidity uvi visibility conditions icon])
            expect(response.keys).to_not eq(%i[pressure dew_point clouds visibility wind_speed wind_deg wind_gust])
        end

        it "get_daily_weather", :vcr do
            response = WeatherFacade.get_daily_weather(@forecast)
            expect(response.class).to eq(Array)
            expect(response.size).to eq(5)
            expect(response.first.size).to eq(7)
            expect(response.first.keys).to eq(%i[date sunrise sunset max_temp min_temp conditions icon])
            expect(response.first.keys).to_not eq(%i[moonrise moonset moon_phase feels_like pressure humidity dew_point wind_speed wind_deg wind_gust weather clouds pop rain uvi])
        end

        it "get_hourly_weather", :vcr do
            response = WeatherFacade.get_hourly_weather(@forecast)
            expect(response.class).to eq(Array)
            expect(response.size).to eq(8)
            expect(response.first.size).to eq(4)
            expect(response.first.keys).to eq(%i[time temp conditions icon])
            expect(response.first.keys).to_not eq(%i[:feels_like pressure humidity dew_point uvi clouds visibility wind_speed wind_deg wind_gust weater pop])

        end
    end
  end
end