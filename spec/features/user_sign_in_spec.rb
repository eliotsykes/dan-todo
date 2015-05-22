require 'rails_helper'

feature "User sign in", type: :feature, js: true do

  xscenario "home page redirects guest to sign in" do
    visit root_path
    expect(page).to have_title("Please sign in")
    expect(current_path).to eq new_user_session_path
    flunk
  end

end
