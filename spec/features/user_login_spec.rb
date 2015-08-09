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
    click_link 'Use your existing account'
    expect(page).to be_login_page

    fill_in 'Enter your email', with: 'someone@somewhere.example'
    fill_in 'Enter your password', with: 'test password'
    click_button 'Sign In'

    expect(page).to have_login_success_message
    expect(page).to have_logged_in_nav
    expect(page).to have_title 'Your Lists'
  end

  scenario 'stays logged in after page refreshes' do
    create :user, email: 'someone@somewhere.example', password: 'test password', password_confirmation: 'test password'

    visit_login_page

    fill_in 'Enter your email', with: 'someone@somewhere.example'
    fill_in 'Enter your password', with: 'test password'

    click_button 'Sign In'
    expect(page).to have_login_success_message
    expect(page).to have_logged_in_nav

    refresh

    expect(page).not_to have_login_success_message
    expect(page).to have_logged_in_nav
  end

  scenario 'should logout user via link' do
    create :user, email: 'someone@somewhere.example', password: 'test password', password_confirmation: 'test password'

    visit_login_page

    fill_in 'Enter your email', with: 'someone@somewhere.example'
    fill_in 'Enter your password', with: 'test password'

    click_button 'Sign In'
    expect(page).to have_login_success_message
    expect(page).to have_logged_in_nav
    expect(current_path).to eq lists_path
    path_requiring_login = current_path

    click_link 'Sign out'
    expect(page).to be_home_page
    expect(page).to have_content 'You have been logged out'

    visit path_requiring_login
    expect(page).to be_login_page
    expect(page).to have_content 'Please login to access this'
  end

  def be_home_page
    have_title('Welcome').and have_css(:h1, text: 'Take charge of your todos')
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
    url = URI.parse(current_url)
    if url.query.blank?
      url.query = ""
    else
      url.query << "&"
    end
    url.query << "refreshEnforcer=#{rand}"
    visit url.to_s
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

  def have_logged_in_nav
    have_link('Sign out').and have_no_link('Sign in').and have_no_link('Register')
  end

  def have_logged_out_nav
    have_link('Sign in').and have_link('Register').and have_no_link('Sign out')
  end

end
