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

    fill_in 'Enter your email', with: 'someone@somewhere.example'
    fill_in 'Enter your password', with: 'test password'
    click_button 'Sign In'

    expect(page).to have_login_success_message
    expect(page).to have_logout_link
    expect(page).to have_title 'Your Lists'
  end

  scenario 'stays logged in after page refreshes' do
    create :user, email: 'someone@somewhere.example', password: 'test password', password_confirmation: 'test password'

    visit_login_page

    fill_in 'Enter your email', with: 'someone@somewhere.example'
    fill_in 'Enter your password', with: 'test password'

    click_button 'Sign In'
    expect(page).to have_login_success_message
    expect(page).to have_logout_link

    refresh

    expect(page).not_to have_login_success_message
    expect(page).to have_logout_link
  end

  scenario 'fails with wrong password' do
    create :user, email: 'someone@somewhere.example', password: 'test password', password_confirmation: 'test password'

    visit_login_page

    fill_in 'Enter your email', with: 'someone@somewhere.example'
    fill_in 'Enter your password', with: 'wrong password'

    click_button 'Sign In'

    expect(page).to have_text 'Sorry, we failed to sign you in, please try again.'
    expect(page).not_to have_login_success_message
    expect(page).to be_login_page
  end

  scenario 'fails with wrong username' do
    create :user, email: 'someone@somewhere.example', password: 'test password', password_confirmation: 'test password'

    visit_login_page

    fill_in 'Enter your email', with: 'not-someone@somewhere.example'
    fill_in 'Enter your password', with: 'test password'

    click_button 'Sign In'

    expect(page).to have_text 'Sorry, we failed to sign you in, please try again.'
    expect(page).not_to have_login_success_message
    expect(page).to be_login_page
  end

  def refresh
    # This JS executes in the browser to reload the current page. Approximate
    # recreation of using the browser refresh button.
    execute_script 'var bypassCache = true; window.location.reload(bypassCache);'
  end

  def visit_login_page
    visit login_path
    expect(page).to be_login_page
  end

  def be_login_page
    have_title('Sign In').and have_css(:h1, text: 'Sign In')
  end

  def have_login_success_message
    have_text 'You are signed in'
  end

  def have_logout_link
    have_link 'Sign out'
  end
end
