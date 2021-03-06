require 'rails_helper'

feature 'Edit list', type: :feature, js: true do

  scenario "updates title" do
    user = create(:user)
    list = create(:list, user: user, title: "Groceries")

    visit_edit_list_page user: user, list: list

    fill_in "List Title", with: "Food"
    click_button "Save"

    expect(page).to be_lists_page
    expect(page).to have_text "Updated list"
    expect(page).to have_no_text "Groceries"
    expect(page).to have_css "li[data-list]", text: "Food"

    list_titles = user.reload.lists.map(&:title)
    expect(list_titles).to eq ["Food"]
  end

  scenario "changes not saved when list is invalid" do
    user = create(:user)
    list = create(:list, user: user, title: "Groceries")

    visit_edit_list_page user: user, list: list

    fill_in "List Title", with: ""
    click_button "Save"

    expect(page).to have_text "Sorry, list was not updated. Title can't be blank"
    expect(page).to be_edit_list_page

    click_link "Cancel"

    expect(page).to be_lists_page
    expect(page).to have_text "Groceries"
  end

  scenario "changes not saved when user cancels" do
    user = create(:user)
    list = create(:list, user: user, title: "Cleaning Supplies")

    visit_edit_list_page user: user, list: list

    fill_in "List Title", with: "Groceries"
    click_link "Cancel"

    expect(page).to be_lists_page
    expect(page).to have_text "Cleaning Supplies"
    expect(page).to have_no_text "Groceries"
  end

  scenario "unlocking edits provides edit list & done options" do
    user = create(:user)
    create(:list, user: user, title: "Cleaning Supplies")
    create(:list, user: user, title: "Groceries")

    visit_login_page_and_login user: user

    expect(page).to be_lists_page
    expect(page).to have_link "+ New List"
    expect(page).to have_no_link "Done"

    click_link "Edit", exact: true
    expect(page).to have_no_link "Edit", exact: true
    expect(page).to have_link "Done"

    expect(page).to have_no_link "+ New List"

    expect(page).to have_css "li[data-list] a", text: "Edit List", count: 2

    click_link "Done"
    expect(page).to have_no_link "Done"
    expect(page).to have_link "Edit", exact: true

    expect(page).to have_no_link "Edit List"
    expect(page).to have_link "+ New List"
  end

  scenario "refreshes successfully" do
    user = create(:user)
    list = create(:list, user: user, title: "Groceries")

    visit_edit_list_page user: user, list: list
    refresh
    
    expect(page).to be_edit_list_page(list)
  end

end
