require 'rails_helper'

describe "Create and Destroy Comment" do

  describe "successful" do
    it "Signs the user up, in, makes a list, then adds and deletes an Item through BDD" do
      user = create(:user)
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

      within '#item-1' do
        click_link 'Delete'
      end

      expect(page).not_to have_content "New Item"

    end
  end
end
