require 'rails_helper'
RSpec.describe "Api::V1::Users", type: :request do

  let(:valid_attributes) {
  {email: 'jennifer@fake.com', password: 'password', password_confirmation: 'password'}
  }

  let(:invalid_attributes) {
  {email: '', password: 'password', password_confirmation: 'password'}
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

  describe "post /users" do
    it "create user and return email with api key", :vcr do
      expect {
            post api_v1_users_url,
                 params: valid_attributes, headers: valid_headers, as: :json
          }.to change(User, :count).by(1)
          expect(response).to have_http_status(201)
          body = JSON.parse(response.body, symbolize_names: true)
          
          expect(body.class).to eq(Hash)
          expect(body[:data].class).to eq(Hash)
          expect(body[:data].keys).to eq( %i[id type attributes])
          expect(body[:data].keys.size).to eq(3)
          expect(body[:data][:attributes].class).to eq(Hash)
          expect(body[:data][:attributes].keys.size).to eq(2)
          expect(body[:data][:attributes].keys).to eq( %i[email api_key])
          
    end

    context "with invalid parameters" do
      it "does not create a new Api::V1::User" do
        expect {
          post api_v1_users_url,
                params: invalid_attributes, headers: valid_headers, as: :json
        }.to change(User, :count).by(0)
          expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Api::V1::User with no password" do
        expect {
          post api_v1_users_url,
                params: {email: 'jennifer@fake.com', password: '', password_confirmation: 'password'}, headers: valid_headers, as: :json
        }.to change(User, :count).by(0)
          expect(response).to have_http_status(:unprocessable_entity)
      end

       it "does not create a new Api::V1::User with no password_confirmation" do
        expect {
          post api_v1_users_url,
                params: {email: 'jennifer@fake.com', password: 'password', password_confirmation: ''}, headers: valid_headers, as: :json
        }.to change(User, :count).by(0)
          expect(response).to have_http_status(:unprocessable_entity)
      end

      it "does not create a new Api::V1::User if password == password_comfirmation" do
        expect {
          post api_v1_users_url,
                params: {email: 'jennifer@fake.com', password: 'password', password_confirmation: 'fdafdsaf'}, headers: valid_headers, as: :json
        }.to change(User, :count).by(0)
          expect(response).to have_http_status(:unprocessable_entity)
      end

      # it "does not create a new with wrong data_type" do
      #   expect {
      #     post api_v1_users_url,
      #           params: valid_attributes, headers: invalid_headers }.to change(User, :count).by(0)
      #     expect(response).to have_http_status(:unprocessable_entity)
      # end
    end
  end
end
     