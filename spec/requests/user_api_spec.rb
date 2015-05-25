require 'rails_helper'

RSpec.describe "User API", type: :request do
  
  context "POST create" do
    
    it "registers a user and requests confirmation" do
      
      headers = { "Content-Type": "application/json" }
      parameters = {
        user: {
          email: "jean@xmen.xmansion",
          password: "mutants rule",
          passwordConfirmation: "mutants rule"
        }
      }.to_json
      
      post "/api/v1/users", parameters, headers

      expect(response).to have_http_status(:no_content)
      
      expect(all_emails.size).to eq(1)
      expect(last_email_sent).to be_delivered_to("jean@xmen.xmansion")
      expect(last_email_sent).to have_subject("Confirmation instructions")

      expect(User.count).to eq(1)
      user = User.last
      expect(user.email).to eq("jean@xmen.xmansion")
      expect(user.confirmed?).to be(false)
    end

  end

end
