require 'rails_helper'

RSpec.describe 'Api::V1::Weather', type: :request do
  let(:valid_attributes) do
    { city_state: 'littleton,co' }
  end

  let(:invalid_attributes) do
    { city_state: '' }
  end

  let(:valid_headers) do
    { 'CONTENT_TYPE' => 'application/json; charset=utf-8' }
    { 'Etag' => 'e0c7402cbf35924277afccc4dc0c5e22' }
    { 'Cache-Control' => 'max-age=0, private, must-revalidate' }
    { 'X-Request-id' => '23e2e7e5-8740-464f-b237-27e33d729f0c' }
    { 'X-Runtime' => '1.757901' }
    { 'Transfer-Encoding' => 'chunked' }
  end
  
  describe 'GET /forecast' do
    it 'returns current hourly and daily weather of the requested city', :vcr do
      get '/api/v1/forecast?location=littleton,co', headers: valid_headers, as: :json
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)

      expect(body[:data].size).to eq(3)
      expect(body[:data].keys).to eq(%i[id type attributes])
      expect(body[:data][:attributes].keys).to eq(%i[current_weather daily_weather hourly_weather])

      expect(body[:data][:attributes][:current_weather][:datetime].class).to eq(String)
      expect(body[:data][:attributes][:current_weather][:sunrise].class).to eq(String)
      expect(body[:data][:attributes][:current_weather][:sunset].class).to eq(String)
      expect(body[:data][:attributes][:current_weather][:temp].class).to eq(Float)
      expect(body[:data][:attributes][:current_weather][:feels_like].class).to eq(Float)
      expect(body[:data][:attributes][:current_weather][:humidity].class).to eq(Float)
      expect(body[:data][:attributes][:current_weather][:uvi].class).to eq(Float)
      expect(body[:data][:attributes][:current_weather][:visibility].class).to eq(Float)
      expect(body[:data][:attributes][:current_weather][:conditions].class).to eq(String)
      expect(body[:data][:attributes][:current_weather][:icon].class).to eq(String)

      expect(body[:data][:attributes][:daily_weather].first[:date].class).to eq(String)
      expect(body[:data][:attributes][:daily_weather].first[:sunrise].class).to eq(String)
      expect(body[:data][:attributes][:daily_weather].first[:sunset].class).to eq(String)
      expect(body[:data][:attributes][:daily_weather].first[:max_temp].class).to eq(Float)
      expect(body[:data][:attributes][:daily_weather].first[:min_temp].class).to eq(Float)
      expect(body[:data][:attributes][:daily_weather].first[:conditions].class).to eq(String)
      expect(body[:data][:attributes][:daily_weather].first[:icon].class).to eq(String)

      expect(body[:data][:attributes][:hourly_weather].first[:time].class).to eq(String)
      expect(body[:data][:attributes][:hourly_weather].first[:temp].class).to eq(Float)
      expect(body[:data][:attributes][:hourly_weather].first[:conditions].class).to eq(String)
      expect(body[:data][:attributes][:hourly_weather].first[:icon].class).to eq(String)
    end

    it 'testing edge case', :vcr do
      get '/api/v1/forecast?location=', headers: valid_headers, as: :json
      expect(response).to have_http_status(400)
    end

    it 'testing quotes', :vcr do
      get '/api/v1/forecast?location=''''', headers: valid_headers, as: :json
      expect(response).to have_http_status(400)
    end

     it 'testing brackets', :vcr do
      get '/api/v1/forecast?location=[]', headers: valid_headers, as: :json
      expect(response).to have_http_status(400)
    end
  end
end
