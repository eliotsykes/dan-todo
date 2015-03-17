require 'rails_helper'

describe "Takes a user through signing up, making a list, creating an item, and destroying it." do

  describe "A successful run through." do
    it "Creates and destroys and item with AJAX.", js: true do
      user = create(:user)
      user.skip_confirmation!
      user.save!
      list = create(:list, user: user)
      visit root_path

      within '.navbar-right' do
        click_link 'Sign In'
      end
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password

      within 'form' do
        click_button 'Sign in'
      end

      expect(current_path).to eq user_path(user)
      expect(page).to have_content "List Title"

      within 'body' do
        click_link 'List Title'
      end

      within 'form' do
        fill_in 'item_name', with: 'New Item'
        click_button 'Add'
      end

      expect(page).to have_content "New Item"

      find(:xpath, "//tr[td[contains(.,'Delete')]]/td/a", :text => 'Delete').click

      expect(page).not_to have_content "New Item"

    end
  end
end
