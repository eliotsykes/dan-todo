require 'rails_helper'

RSpec.describe "Session API", :type => :request do

  describe "POST create" do
    
    it "responds with the authenticated API token" do

      user = create(:user, 
        email: "barry@goldbergs.tv", 
        password: "unreasonable power",
        password_confirmation: "unreasonable power",
        api_key: "ApiKeyForSessionApiTesting"
      )

      parameters = {
        user: {
          email: "barry@goldbergs.tv",
          password: "unreasonable power"
        }
      }.to_json

      post "/api/v1/sessions", parameters, json_request_headers

      expect(response).to have_http_status(:created)
      expect(response.content_type).to eq("application/json")
      
      expect(json).to eq(token: "ApiKeyForSessionApiTesting")
    end

    it "responds with 400 Bad Request for no params" do

      no_parameters = {}.to_json

      respond_without_detailed_exceptions do
        post "/api/v1/sessions", no_parameters, json_request_headers
      end

      expect(response).to have_http_status(:bad_request)
      expect(response.content_type).to eq("application/json")

      expect(json).to eq(status: "400", error: "Bad Request")
    end

    it "responds with 400 Bad Request for missing password" do

      user = create(:user)

      parameters_without_password = {
        user: { email: user.email }
      }.to_json

      respond_without_detailed_exceptions do
        post "/api/v1/sessions", parameters_without_password, json_request_headers
      end

      expect(response).to have_http_status(:bad_request)
      expect(response.content_type).to eq("application/json")

      expect(json).to eq(status: "400", error: "Bad Request")
    end

    it "responds with 400 Bad Request for missing email" do

      user = create(:user,  
        password: "unreasonable power",
        password_confirmation: "unreasonable power",
      )

      parameters_without_email = {
        user: {
          password: "unreasonable power"
        }
      }.to_json

      respond_without_detailed_exceptions do
        post "/api/v1/sessions", parameters_without_email, json_request_headers
      end

      expect(response).to have_http_status(:bad_request)
      expect(response.content_type).to eq("application/json")

      expect(json).to eq(status: "400", error: "Bad Request")
    end

    it "responds with 406 Not Acceptable for non-JSON Accept header" do
      headers = { "Content-Type" => "application/json", "Accept" => "text/html" }
      parameters = {}

      respond_without_detailed_exceptions do
        post "/api/v1/sessions", parameters, headers
      end

      expect(response).to have_http_status(:not_acceptable)
      expect(response.content_type).to eq("text/html")
      expect(response.body).to be_empty
    end

    it "responds with 415 Unsupported Media Type for non-JSON request content type" do

      headers = { "Content-Type" => "text/html; charset=utf-8", "Accept" => "application/json" }

      respond_without_detailed_exceptions do
        post "/api/v1/sessions", {}
      end

      expect(response).to have_http_status(:unsupported_media_type)
      expect(response.content_type).to eq("text/html")
      expect(response.body).to be_empty
    end

    it "responds with 404 Not Found for unknown email" do
      user = create(:user,
        password: "unreasonable power",
        password_confirmation: "unreasonable power"
      )

      parameters_with_unknown_email = {
        user: {
          email: "not.#{user.email}",
          password: "unreasonable power"
        }
      }.to_json

      respond_without_detailed_exceptions do
        post "/api/v1/sessions", parameters_with_unknown_email, json_request_headers
      end

      expect(response).to have_http_status(:not_found)
      expect(response.content_type).to eq("application/json")

      expect(json).to eq(status: "404", error: "Not Found")
    end

    xit "responds with error for incorrect password" do
      post "/api/v1/sessions", parameters, json_request_headers
      flunk
    end

    xit "brute force password attack locks user" do
      flunk
    end

  end

end
