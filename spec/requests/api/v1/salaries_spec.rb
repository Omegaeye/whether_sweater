require 'rails_helper'

RSpec.describe "Api::V1::Salaries", type: :request do

    let(:valid_attributes) {
    {destination: 'chicago'}
  }

  let(:invalid_attributes) {
  {destination: ''}
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
    
    it "returns current hourly and daily weather of the requested city" do
      get '/api/v1/salaries', params: valid_attributes, headers: valid_headers, as: :json
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
    end
  end
end

