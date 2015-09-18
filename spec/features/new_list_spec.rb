require 'rails_helper'

feature 'New list', type: :feature, js: true do

  scenario 'added successfully' do
    user = create(:user)
    visit_new_list_page user: user

    fill_in "List Title", with: "Groceries"
    click_button "Save"

    expect(page).to be_lists_page
    expect(page).to have_text "New list created."
    expect(page).to have_css "li[data-list]", text: "Groceries"

    list_titles = user.lists.pluck(:title)
    expect(list_titles).to eq(["Groceries"]), "List should be saved to database"
  end

  scenario 'not added when list is invalid' do
    user = create(:user)
    visit_new_list_page user: user

    expect(page).to have_field("List Title", with: "")
    click_button "Save"

    expect(page).to have_text "Sorry, list was not created. Title can't be blank"
    expect(page).to be_new_list_page
    expect(List.count).to eq(0)

    click_link "Cancel"
    expect(page).to be_lists_page
    expect(page).to(
      have_no_css("li[data-list]", visible: false),
      "Unsaved Ember Data objects should not be shown in list"
    )
  end

  scenario 'not added when user cancels' do
    user = create(:user)
    create(:list, user: user, title: "Cleaning Supplies")
    visit_new_list_page user: user

    fill_in "List Title", with: "Groceries"
    click_link "Cancel"

    expect(page).to be_lists_page
    expect(page).to have_text "Cleaning Supplies"
    expect(page).to have_no_text "Groceries"
    expect(page).to(
      have_css("li[data-list]", visible: false, count: 1),
      "Unsaved list should not be shown in list"
    )
  end

  private

  def visit_new_list_page(user:)
    visit_login_page_and_login user: user
    expect(page).to be_lists_page
    click_link "+ New List"
    expect(page).to be_new_list_page
  end

end
