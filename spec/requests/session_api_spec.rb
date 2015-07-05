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

    it "responds with 400 Bad Request HTTP status for no params" do

      no_parameters = {}.to_json

      without_error_debugging do
        post "/api/v1/sessions", no_parameters, json_request_headers
      end

      expect(response).to have_http_status(:bad_request)
      expect(response.content_type).to eq("application/json")

      expect(json).to eq(status: "400", error: "Bad Request")
    end

    xit "responds with 400 Bad Request HTTP status for missing password" do

      no_parameters = {}.to_json
      post "/api/v1/sessions", no_parameters, json_request_headers

      expect(response).to have_http_status(:bad_request)
      expect(response.content_type).to eq("application/json")

      expect(response.body).to be_empty
      flunk
    end

    xit "responds with 400 Bad Request HTTP status for missing email" do

      no_parameters = {}.to_json
      post "/api/v1/sessions", no_parameters, json_request_headers

      expect(response).to have_http_status(:bad_request)
      expect(response.content_type).to eq("application/json")

      expect(response.body).to be_empty
      flunk
    end

    xit "responds with 406 Not Acceptable for wrong request format headers" do
      # ActionController::UnknownFormat
      flunk      
    end



    xit "responds with error for unrecognized email" do
      post "/api/v1/sessions", parameters, json_request_headers
      flunk
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
