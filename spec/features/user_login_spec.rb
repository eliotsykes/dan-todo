require 'rails_helper'

feature 'User login', type: :feature, js: true do

  around :each do |example|
    respond_without_detailed_exceptions do
      example.run
    end
  end

  scenario 'successful with correct credentials' do
    create :user, email: 'someone@somewhere.example', password: 'test password', password_confirmation: 'test password'

    visit root_path
    click_link 'Sign in'
    expect(page).to be_login_page

    login(
      email: 'someone@somewhere.example',
      password: 'test password',
      clear_notifications: false
    )

    expect(page).to have_login_success_message
    expect(page).to have_logged_in_nav
    expect(page).to have_title 'Your Lists'
  end

  scenario 'stays logged in after page refreshes' do
    create :user, email: 'someone@somewhere.example', password: 'test password', password_confirmation: 'test password'

    visit_login_page_and_login(
      email: 'someone@somewhere.example',
      password: 'test password',
      clear_notifications: false
    )

    expect(page).to have_login_success_message
    expect(page).to have_logged_in_nav

    refresh

    expect(page).not_to have_login_success_message
    expect(page).to have_logged_in_nav
  end

  scenario 'should logout user via link' do
    create :user, email: 'someone@somewhere.example', password: 'test password', password_confirmation: 'test password'

    visit_login_page_and_login(
      email: 'someone@somewhere.example',
      password: 'test password',
      clear_notifications: false
    )

    expect(page).to have_login_success_message
    expect(page).to have_logged_in_nav

    click_link 'Sign out'
    expect(page).to have_logged_out_nav

    refresh

    expect(page).to have_logged_out_nav
  end

  scenario 'fails with wrong password' do
    create :user, email: 'someone@somewhere.example', password: 'test password', password_confirmation: 'test password'

    visit_login_page_and_login(
      email: 'someone@somewhere.example',
      password: 'wrong password',
      clear_notifications: false
    )

    expect(page).to have_text 'Sorry, we failed to sign you in, please try again.'
    expect(page).not_to have_login_success_message
    expect(page).to be_login_page
  end

  scenario 'fails with wrong username' do
    create :user, email: 'someone@somewhere.example', password: 'test password', password_confirmation: 'test password'

    visit_login_page_and_login(
      email: 'not-someone@somewhere.example',
      password: 'test password',
      clear_notifications: false
    )

    expect(page).to have_text 'Sorry, we failed to sign you in, please try again.'
    expect(page).not_to have_login_success_message
    expect(page).to be_login_page
  end

end
