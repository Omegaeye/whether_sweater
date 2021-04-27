require 'rails_helper'

RSpec.describe "Api::V1::Images", type: :request do

    let(:valid_attributes) {
    {location: 'denver,co'}
  }

  let(:invalid_attributes) {
  {location: ''}
  }

  let(:valid_headers) {
    {"CONTENT_TYPE" => "application/json; charset=utf-8"}
    {"Etag" => "b13ad756286208ab0f16e6175850a0b3"}
    {"Cache-Control" => "max-age=0, private, must-revalidate"}
    {"X-Request-id" => "e36cb5e5-e323-4e19-9988-d328a552b8e4"}
    {"X-Runtime" => "0.459118"}
    {"Transfer-Encoding" => "chunked"}
  }
  describe "GET /backgrounds" do
    it "returns background image of the requested city", :vcr do
      get '/api/v1/backgrounds?location=denver,co', headers: valid_headers, as: :json
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
       expect(body[:data].size).to eq(3)
       expect(body[:data].keys).to eq(%i[id type attributes])
       expect(body[:data][:attributes][:image].keys).to eq(%i[location image_url credit])
       expect(body[:data][:attributes][:image][:credit].keys).to eq(%i[source author])

       expect(body[:data][:attributes][:image][:location]).to eq('denver,co')
       expect(body[:data][:attributes][:image][:image_url]).to be_a(String)
       expect(body[:data][:attributes][:image][:credit][:source]).to eq('flickr.com')
       expect(body[:data][:attributes][:image][:credit][:author]).to eq('mudsharkalex')

    end

    it "returns 404 when given no params" do
      get '/api/v1/backgrounds?location=', headers: valid_headers, as: :json
      expect(response).to have_http_status(404)
    end

     it "returns b when given no params", :vcr do
      get '/api/v1/backgrounds?location=fdafda', headers: valid_headers, as: :json
      expect(response).to have_http_status(200)
      expect(response)
    end
  end
end
