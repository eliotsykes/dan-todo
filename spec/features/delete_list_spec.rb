require 'rails_helper'

feature 'Delete list', type: :feature, js: true do

  scenario 'removes list' do
    user = create(:user)
    list = create(:list, user: user, title: "Groceries")

    visit_edit_list_page user: user, list: list

    confirmation_message = accept_confirm do
      click_button "Delete"
    end
    expect(confirmation_message).to eq "Are you sure you want to delete this list?"

    expect(page).to have_text "List deleted."
    expect(page).to be_lists_page
    expect(page).to have_no_text "Groceries"
    expect(List.count).to eq(0)
  end

  scenario "prevents delete when user cancels" do
    user = create(:user)
    list = create(:list, user: user, title: "Groceries")

    visit_edit_list_page user: user, list: list

    confirmation_message = dismiss_confirm do
      click_button "Delete"
    end
    expect(confirmation_message).to eq "Are you sure you want to delete this list?"

    expect(page).to be_edit_list_page list

    click_link "Cancel"

    expect(page).to be_lists_page
    expect(page).to have_text "Groceries"
    expect(list.reload.persisted?).to eq true
  end

end
