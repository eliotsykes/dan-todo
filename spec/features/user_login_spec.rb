require 'rails_helper'

feature 'User login', type: :feature, js: true do

  scenario 'successful with correct credentials' do
    create :user, email: 'someone@somewhere.example', password: 'test password', password_confirmation: 'test password'

    visit root_path
    click_link 'Sign in'

    expect(page).to have_title 'Sign In'
    expect(page).to have_css :h1, text: 'Sign In'

    fill_in 'Enter your email', with: 'someone@somewhere.example'
    fill_in 'Enter your password', with: 'test password'
    click_button 'Sign In'

    expect(page).to have_login_success_message
    expect(page).to have_title 'Your Lists'
  end

  scenario 'fails with wrong password' do
    create :user, email: 'someone@somewhere.example', password: 'test password', password_confirmation: 'test password'

    visit login_path

    expect(page).to have_title 'Sign In'

    fill_in 'Enter your email', with: 'someone@somewhere.example'
    fill_in 'Enter your password', with: 'wrong password'

    respond_without_detailed_exceptions do
      click_button 'Sign In'
    end

    expect(page).to have_text 'Sorry, we failed to sign you in, please try again.'
    expect(page).not_to have_login_success_message
    expect(page).to have_title 'Sign In'
  end

  def have_login_success_message
    have_text 'You are signed in'
  end

  xscenario 'fails with bad username'
  xscenario 'prompts for missing credentials'
end
