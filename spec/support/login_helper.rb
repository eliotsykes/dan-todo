module LoginHelper

  def visit_login_page_and_login(*args)
    visit_login_page
    login(*args)
  end

  def visit_login_page
    visit login_path
    expect(page).to be_login_page
  end

  def be_login_page
    have_title('Sign In').and have_css(:h1, text: 'Sign In')
  end

  def login(email: nil, password: nil, user: nil, clear_notifications: true)
    email, password = user.email, user.password if user
    fill_in 'Enter your email', with: email
    fill_in 'Enter your password', with: password
    click_button 'Sign In'
    clear_notifications() if clear_notifications
  end

  def clear_notifications
    click_button "Close"
  end

  def logout
    visit '/logout'
    expect(page).to have_content 'You have been logged out.'
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

RSpec.configure do |config|

  config.include LoginHelper, type: :feature

  config.before(:each, type: :feature) do
    logout
  end

end
