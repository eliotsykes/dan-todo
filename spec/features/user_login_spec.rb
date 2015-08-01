require 'rails_helper'

feature "User login", type: :feature, js: true do

  scenario "successful with correct credentials" do
    create :user, email: "someone@somewhere.example", password: "test password", password_confirmation: "test password"

    visit root_path
    click_link "Sign in"

    expect(page).to have_title "Sign In"
    expect(page).to have_css :h1, text: "Sign In"

    fill_in "Enter your email", with: "someone@somewhere.example"
    fill_in "Enter your password", with: "test password"
    click_button "Sign In"

    expect(page).to have_text "You are signed in"
    expect(page).to have_title "Your Lists"
  end

  xscenario "fails with bad password"
  xscenario "fails with bad username"
  xscenario "prompts for missing credentials"
end
