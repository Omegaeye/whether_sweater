require 'rails_helper'
RSpec.describe "Api::V1::Sessions", type: :request do

  let(:valid_attributes) {
  {email: 'jennifer@fake.com', password: 'password', password_confirmation: 'password'}
  }

   let(:log_in_valid_attributes) {
  {email: 'jennifer@fake.com', password: 'password'}
  }

  let(:invalid_attributes) {
  {email: 'jennifer@fake.com', password: 'pad'}
  }

  let(:valid_headers) {
    {"CONTENT_TYPE" => "application/json; charset=utf-8"}
    {"Etag" => "b13ad756286208ab0f16e6175850a0b3"}
    {"Cache-Control" => "max-age=0, private, must-revalidate"}
    {"X-Request-id" => "e36cb5e5-e323-4e19-9988-d328a552b8e4"}
    {"X-Runtime" => "0.459118"}
    {"Transfer-Encoding" => "chunked"}
  }

  let(:invalid_headers) {
    {"CONTENT_TYPE" => "xtml"}
    {"Etag" => "b13ad756286208ab0f16e6175850a0b3"}
    {"Cache-Control" => "max-age=0, private, must-revalidate"}
    {"X-Request-id" => "e36cb5e5-e323-4e19-9988-d328a552b8e4"}
    {"X-Runtime" => "0.459118"}
    {"Transfer-Encoding" => "chunked"}
  }

    describe "post /sessions" do
        it "authenticate user password and password_confirmation, return email and api_key", :vcr do
            @user = User.create!(valid_attributes)
            @user.api_keys.create!(token: SecureRandom.hex)
            
            post api_v1_sessions_url, params: log_in_valid_attributes, headers: valid_headers, as: :json
            
            expect(response).to have_http_status(200)
            body = JSON.parse(response.body, symbolize_names: true)
            expect(body.class).to eq(Hash)
            expect(body[:data].class).to eq(Hash) 
            expect(body[:data].size).to eq(3)
            expect(body[:data].keys).to eq(%i[id type attributes]) 
            expect(body[:data][:attributes].class).to eq(Hash)
            expect(body[:data][:attributes].size).to eq(2)
            expect(body[:data][:attributes].keys).to eq( %i[email api_key])
        end

        it "return no auth sad path", :vcr do
            @user = User.create!(valid_attributes)
            @user.api_keys.create!(token: SecureRandom.hex)
            
            post api_v1_sessions_url, params: invalid_attributes, headers: valid_headers, as: :json
            
            expect(response).to have_http_status(401)
        end

         it "return no auth edge case", :vcr do
            @user = User.create!(valid_attributes)
            @user.api_keys.create!(token: SecureRandom.hex)
            post api_v1_sessions_url, params: '', headers: valid_headers, as: :json
            expect(response).to have_http_status(401)
        end
    end
end     
