require 'rails_helper'

feature 'Delete list', type: :feature, js: true do

  scenario 'removes list' do
    user = create(:user)
    list = create(:list, user: user, title: "Groceries")

    visit_login_page_and_login user: user
    click_link "Edit"

    expect(page).to be_edit_list_page
    expect(page).to have_field("List Title", with: "Groceries")
    click_button "Delete"

    expect(page).to have_confirm("Delete list?")
    confirm_dialog

    expect(page).to be_lists_page
    expect(page).to have_text "List deleted"
    expect(page).to have_no_text "Groceries"
    expect(List.count).to eq(0)
  end

end
