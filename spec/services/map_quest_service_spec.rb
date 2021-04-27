require 'rails_helper'

RSpec.describe MapQuestService, type: :model do
    describe "Testing class method" do
        it "get_lon_and_lat", :vcr do
            response = MapQuestService.get_lon_and_lat('chicago,il')
 
            expect(response.class).to eq(Hash)
        end
    end
end