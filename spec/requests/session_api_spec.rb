require 'rails_helper'

RSpec.describe "Session API", :type => :request do

  describe "POST /api/v1/sessions" do
    
    it "responds with the authenticated API token" do

      user = create(:user, 
        email: "barry@goldbergs.tv", 
        password: "unreasonable power",
        password_confirmation: "unreasonable power",
        api_key: "ApiKeyForSessionApiTesting"
      )

      headers = { "Content-Type": "application/json" }
      parameters = {
        user: {
          email: "barry@goldbergs.tv",
          password: "unreasonable power"
        }
      }.to_json

      post "/api/v1/sessions", parameters, headers

      expect(response).to have_http_status(:created)
      expect(response.content_type).to eq("application/json")
      
      # TODO: Introduce JSON helper in spec/support.
      json = JSON.parse(response.body, symbolize_names: true)
      expect(json).to eq(token: "ApiKeyForSessionApiTesting")
    end

    xit "reponds with error for unrecognized email" do
      post "/api/v1/sessions", parameters, headers
      flunk
    end

    xit "reponds with error for incorrect password" do
      post "/api/v1/sessions", parameters, headers
      flunk
    end

    xit "reponds with error for no credential params" do
      post "/api/v1/sessions", parameters, headers
      flunk
    end

    xit "brute force password attack locks user" do
      flunk
    end

  end

end
