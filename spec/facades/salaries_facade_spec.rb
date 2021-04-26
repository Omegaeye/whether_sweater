require 'rails_helper'

RSpec.describe SalariesFacade, type: :model do

  describe "class methods" do
    it "city_job_weather_info" do
        response = SalariesFacade.city_job_weather_info('chicago')
        expect(response.class).to eq(OpenStruct)
        expect(response.destination.present?).to eq(true)
        expect(response.forecast.present?).to eq(true)
        expect(response.salaries.present?).to eq(true)

    end

     it "urban_jobs_salary" do
        response = SalariesFacade.urban_jobs_salary('chicago')
        expect(response.class).to eq(Array)
        expect(response.first.keys).to eq(%i[title min max])
        expect(response.first.keys.size).to eq(3)
        expect(response.first.keys.size).to_not eq(4)
        expect(response.first.keys.size).to_not eq(2)
    end

     it "location_weatgher" do
        response = SalariesFacade.location_weather('chicago')
        expect(response.class).to eq(Hash)
        expect(response.keys.size).to eq(2)
        expect(response.keys.size).to_not eq(1)
        expect(response.keys.size).to_not eq(3)
        expect(response.keys).to eq(%i[summary temperature])
    end
  end
end