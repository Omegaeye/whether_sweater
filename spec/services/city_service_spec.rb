require 'rails_helper'

RSpec.describe CityService, type: :model do
    describe "Testing class method" do
        it "get_salaries"do
            response = CityService.get_salaries('chicago')
            expect(response.class).to eq(Array)
            expect(response.first['job'].present?).to eq(true)
            expect(response.first['salary_percentiles'].present?).to eq(true)
        end

         it "get_urban_area"do
            response = CityService.get_urban_area('chicago')
            expect(response.class).to eq(Hash)
            expect(response['_links']['ua:salaries'].present?).to eq(true)
        end

        it "get_city_info"do
            response = CityService.get_city_info('chicago')
            expect(response.class).to eq(Hash)
            expect(response['_links']['city:urban_area'].present?).to eq(true)
        end

        it "get_city"do
            response = CityService.get_city('chicago')
            expect(response.class).to eq(String)
        end
    end
end