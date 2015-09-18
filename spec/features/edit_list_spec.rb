require 'rails_helper'

feature 'Edit list', type: :feature, js: true do

  scenario "updates title" do
    user = create(:user)
    create(:list, user: user, title: "Groceries")

    visit_login_page_and_login user: user
    click_link "Edit"
    click_link "Edit List"

    expect(page).to be_edit_list_page
    expect(page).to have_field("List Title", with: "Groceries")

    fill_in "List Title", with: "Food"
    click_button "Save"

    expect(page).to be_lists_page
    expect(page).to have_text "List title updated"
    expect(page).to have_no_text "Groceries"
    expect(page).to have_css "li[data-list]", text: "Food"

    list_titles = user.reload.lists.map(&:title)
    expect(list_titles).to eq ["Food"]
  end

  scenario "unlocking edits provides edit list & done options" do
    user = create(:user)
    create(:list, user: user, title: "Cleaning Supplies")
    create(:list, user: user, title: "Groceries")

    visit_login_page_and_login user: user

    expect(page).to be_lists_page
    expect(page).to have_link "+ New List"
    expect(page).to have_no_link "Done"

    within "header" do
      click_link "Edit"
      expect(page).to have_no_link "Edit"
      expect(page).to have_link "Done"
    end

    expect(page).to have_no_link "+ New List"

    expect(page).to have_css "li[data-list] a", text: "Edit List", count: 2

    within "header" do
      click_link "Done"
      expect(page).to have_no_link "Done"
      expect(page).to have_link "Edit"
    end

    expect(page).to have_no_link "Edit List"
    expect(page).to have_link "+ New List"
  end


end
