require 'rails_helper'

feature "User registration", type: :feature, js: true do

  scenario "successful with valid details" do
    visit root_path

    click_link "Register"

    expect(page).to have_title("Please register")
    expect(page).to have_css(:h1, text: /\ALet.s get you signed up.\z/)

    fill_in "Enter your email", with: "clark@dailyplanet.metropolis"
    fill_in "Enter new password", with: "im superman"
    fill_in "Re-enter password", with: "im superman"
    click_button "Create your account"

    expect(page).to have_title("Please confirm")
    expect(page).to have_text("Please check your inbox")

    open_email "clark@dailyplanet.metropolis", subject: "Confirm your account"
    click_first_link_in_email

    expect(page).to have_title("Sign In")
    expect(page).to have_text("Your account has been confirmed, thank you!")

    fill_in "Enter your email", with: "clark@dailyplanet.metropolis"
    fill_in "Enter your password", with: "im superman"
    click_button "Sign In"

    expect(page).to have_text("You are signed in")
  end

end
