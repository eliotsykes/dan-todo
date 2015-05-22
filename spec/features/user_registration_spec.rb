require 'rails_helper'

feature "User registration", type: :feature, js: true do
  
  xscenario "sign in page links to registration" do
    flunk
  end

  scenario "successful with valid details" do
    visit new_user_registration_path

    expect(page).to have_title("Please register")
    expect(current_path).to eq new_user_registration_path

    fill_in "Email", with: "clark@dailyplanet.metropolis"
    fill_in "Password", with: "im superman"
    fill_in "Confirm password", with: "im superman"
    click_button "Register"

    expect(page).to have_title("Please confirm")
    expect(current_path).to eq user_confirmation_pending_path
    expect(page).to have_text("Please check your inbox and click the link to confirm your account.")
    
    open_email "clark@dailyplanet.metropolis", subject: "Confirm your account"
    click_first_link_in_email
    
    expect(page).to have_title("Confirmation successful")
    expect(current_path).to eq user_confirmed_path
    expect(page).to have_text("Your account has been confirmed, thank you!")

    click_link "Write your first todo"

    flunk
  end

end
