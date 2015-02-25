require 'rails_helper'

describe "Sign in flow" do

  describe "successful" do
    it "Signs the user up, logs the user in, and checks the users name after login" do
      user = create(:user)
      visit root_path

      within '.navbar-right' do
        click_link 'Sign In'
      end
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password

      within 'form' do
        click_button 'Sign in'
      end

      expect(current_path).to eq root_path
      expect(page).to have_content "Hello #{user.name}"

    end
  end
end
