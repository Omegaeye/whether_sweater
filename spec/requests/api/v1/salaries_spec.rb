require 'rails_helper'

RSpec.describe "Api::V1::Salaries", type: :request do

    let(:valid_attributes) {
    {destination: 'chicago'}
  }

  let(:invalid_attributes) {
  {destination: 'fdsafdsafd'}
  }

  let(:valid_headers) {
    {"CONTENT_TYPE" => "application/json; charset=utf-8"}
    {"Etag" => "e0c7402cbf35924277afccc4dc0c5e22"}
    {"Cache-Control" => "max-age=0, private, must-revalidate"}
    {"X-Request-id" => "23e2e7e5-8740-464f-b237-27e33d729f0c"}
    {"X-Runtime" => "1.757901"}
    {"Transfer-Encoding" => "chunked"}
  }
  describe "GET /salaries" do
    
    it "returns current hourly and daily weather of the requested city", :vcr do
      get '/api/v1/salaries', params: valid_attributes, headers: valid_headers, as: :json
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:data].size).to eq(3)
      expect(body[:data].keys).to eq(%i[id type attributes])
      expect(body[:data][:attributes].keys).to eq(%i[destination forecast salaries])
      expect(body[:data][:attributes][:forecast].size).to eq(2)
      expect(body[:data][:attributes][:forecast].keys).to eq(%i[summary temperature])
      expect(body[:data][:attributes][:salaries].class).to eq(Array)
      expect(body[:data][:attributes][:salaries].first.size).to eq(3)
      expect(body[:data][:attributes][:salaries].first.keys).to eq(%i[title min max])
    end

     it "returns denver info with destination = fdsafdsafd", :vcr do
      get '/api/v1/salaries', params: invalid_attributes, headers: valid_headers, as: :json
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:data].size).to eq(3)
      expect(body[:data].keys).to eq(%i[id type attributes])
      expect(body[:data][:attributes].keys).to eq(%i[destination forecast salaries])
      expect(body[:data][:attributes][:forecast].size).to eq(2)
      expect(body[:data][:attributes][:forecast].keys).to eq(%i[summary temperature])
      expect(body[:data][:attributes][:salaries].class).to eq(Array)
      expect(body[:data][:attributes][:salaries].first.size).to eq(3)
      expect(body[:data][:attributes][:salaries].first.keys).to eq(%i[title min max])

      expect(body[:data][:attributes][:destination]).to eq('Denver')

    end


     it "returns denver info with destination = ", :vcr do
      get '/api/v1/salaries', params: {}, headers: valid_headers, as: :json
      
      expect(response).to have_http_status(422)
     end
  end
end

