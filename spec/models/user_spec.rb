require 'rails_helper'

RSpec.describe User, type: :model do
    describe "Validation" do
        it { should validate_presence_of(:email) }
    end

    describe "Relationship" do
        it { should have_many(:api_keys) }
    end

    describe "Testing Class Methods" do
      context "user_info" do
        it "return an OpenStruct with id email and api_key" do
            @user = User.create!(id: 100, email: 'jennifer@fake.com', password: 'password', password_confirmation: 'password')
            response = User.user_info(@user.id)
            expect(response).to be_a(OpenStruct) 
            expect(response[:id].present?).to eq(true) 
            expect(response[:email].present?).to eq(true) 
            expect(response[:api_key].present?).to eq(true) 
        end
      end
      context "user_log_in" do
        it "return OpenStruct with user id email and api_key" do
            @user = User.create!(id: 100, email: 'jennifer@fake.com', password: 'password', password_confirmation: 'password')
            @user.api_keys.create!(token: SecureRandom.hex)
            response = User.user_log_in(@user.id)
            expect(response).to be_a(OpenStruct)
            expect(response[:id].present?).to eq(true)
            expect(response[:email].present?).to eq(true)
            expect(response[:api_key].present?).to eq(true)
        end
      end
    end
end
