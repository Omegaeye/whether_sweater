require 'rails_helper'

RSpec.describe "Api::V1::RoadTrips", type: :request do
  let(:valid_attributes) {
  {email: 'jennifer@fake.com', password: 'password', password_confirmation: 'password'}
  }

    let(:sign_in_valid_attributes_hourly) {
    {
      origin: 'denver,co',
      destination: 'littleton,co',
      api_key: @user.api_keys.first.token
    }
  }

   let(:sign_in_valid_attributes_daily) {
    {
      origin: 'anchorage',
      destination: 'denver',
      api_key: @user.api_keys.first.token
    }
  }
  
  let(:invalid_attributes) {
    {
      origin: '',
      destination: 'denver',
      api_key: @user.api_keys.first.token
    }
  }

    let(:no_destination_attributes) {
    {
      origin: 'denver',
      destination: ' ',
      api_key: @user.api_keys.first.token
    }
  }

  let(:no_api_key_attributes) {
    {
      origin: 'anchorage',
      destination: 'denver',
      api_key: ''
    }
  }

    let(:no_destination_param) {
    {
      origin: 'anchorage',
      api_key: @user.api_keys.first.token
    }
  }

     let(:no_destination_attributes) {
       {
        origin: 'sitka,ak',
        destination: 'germany',
        api_key: @user.api_keys.first.token
      } 
    }
  
  let(:valid_headers) {
    {"CONTENT_TYPE" => "application/json; charset=utf-8"}
    {"Etag" => "e0c7402cbf35924277afccc4dc0c5e22"}
    {"Cache-Control" => "max-age=0, private, must-revalidate"}
    {"X-Request-id" => "23e2e7e5-8740-464f-b237-27e33d729f0c"}
    {"X-Runtime" => "1.757901"}
    {"Transfer-Encoding" => "chunked"}
  }

  describe "GET /index" do   
    it "return direction and weather info", :vcr do
      @user = User.create!(valid_attributes)
      @user.api_keys.create!(token: SecureRandom.hex)
      post '/api/v1/road_trip', params: sign_in_valid_attributes_hourly, headers: valid_headers, as: :json
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      
      expect(body).to be_a(Hash)
      expect(body[:data]).to be_a(Hash)
      expect(body[:data].size).to eq(3)
      expect(body[:data].size).to_not eq(2)
      expect(body[:data].size).to_not eq(4)
      expect(body[:data].keys).to eq(%i[id type attributes])
      expect(body[:data][:attributes].size).to eq(4)
      expect(body[:data][:attributes].size).to_not eq(2)
      expect(body[:data][:attributes].size).to_not eq(5)
      expect(body[:data][:attributes].keys).to eq(%i[start_city end_city travel_time weather_at_eta])
      expect(body[:data][:attributes][:weather_at_eta].size).to eq(2)
      expect(body[:data][:attributes][:weather_at_eta].size).to_not eq(1)
      expect(body[:data][:attributes][:weather_at_eta].size).to_not eq(3)
      expect(body[:data][:attributes][:weather_at_eta].keys).to eq(%i[temperature summary])

    end

    it "return daily weather direction and weather info", :vcr do
      @user = User.create!(valid_attributes)
      @user.api_keys.create!(token: SecureRandom.hex)
      post '/api/v1/road_trip', params: sign_in_valid_attributes_daily, headers: valid_headers, as: :json
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:data][:attributes][:travel_time]).to eq('2 days, 3 hours, 57 minutes, and 46 seconds')
    end

    it "return errors with invalid params", :vcr do
       @user = User.create!(valid_attributes)
       @user.api_keys.create!(token: SecureRandom.hex)
       post '/api/v1/road_trip', params: invalid_attributes, headers: valid_headers, as: :json
       expect(response).to have_http_status(400)
       body = JSON.parse(response.body, symbolize_names: true)
       expect(body[:errors]).to eq(["origin parameter is bad: cannot be empty/blank"])
    end

    it "return errors with invalid params", :vcr do
      @user = User.create!(valid_attributes)
      @user.api_keys.create!(token: SecureRandom.hex)
      post '/api/v1/road_trip', params: invalid_attributes, headers: valid_headers, as: :json
      expect(response).to have_http_status(400)
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:errors]).to eq(["origin parameter is bad: cannot be empty/blank"])
    end

    it "return errors with invalid no api key params", :vcr do
      @user = User.create!(valid_attributes)
      @user.api_keys.create!(token: SecureRandom.hex)
      post '/api/v1/road_trip', params: no_api_key_attributes, headers: valid_headers, as: :json
      expect(response).to have_http_status(401)
    end

     it "return errors with no destinationparam", :vcr do
      @user = User.create!(valid_attributes)
      @user.api_keys.create!(token: SecureRandom.hex)
      post '/api/v1/road_trip', params: no_destination_param, headers: valid_headers, as: :json
      expect(response).to have_http_status(400)
       body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:errors]).to eq(["either origin, or destination, or api_key parameter was not included in your request"])
    end

     it "return errors with blank destination param", :vcr do
      @user = User.create!(valid_attributes)
      @user.api_keys.create!(token: SecureRandom.hex)
      post '/api/v1/road_trip', params: no_destination_attributes, headers: valid_headers, as: :json
      expect(response).to have_http_status(400)
       body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:errors]).to eq("parameter is bad: [false, \"You will need a jetpack for that route\"]")
    end

       it "return errors with bad request", :vcr do
        @user = User.create!(valid_attributes)
        @user.api_keys.create!(token: SecureRandom.hex)

        post '/api/v1/road_trip', params: no_destination_attributes, headers: valid_headers, as: :json
        expect(response).to have_http_status(400)
        body = JSON.parse(response.body, symbolize_names: true)
        expect(body[:errors]).to eq("parameter is bad: [false, \"You will need a jetpack for that route\"]")
    end
  end
end
