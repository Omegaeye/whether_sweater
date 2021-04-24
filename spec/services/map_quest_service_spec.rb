require 'rails_helper'

RSpec.describe MapQuestService, type: :model do
    describe "Testing class method" do
        it "get_forecast", :vcr do
            response = MapQuestService.get_lon_and_lat('littleton,co')
            expect(response.class).to eq(Hash)
        end
    end
end