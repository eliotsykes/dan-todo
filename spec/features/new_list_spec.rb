require 'rails_helper'

feature 'New list', type: :feature, js: true do

  scenario 'added successfully' do
    user = create(:user)
    visit_new_list_page user: user

    fill_in "List Title", with: "Groceries"
    click_button "Save"

    expect(page).to have_text "New list saved successfully."
    expect(page).to have_title "Your Lists"
    expect(page).to have_css "h1", text: "Your Lists"
    expect(page).to have_css "li", text: "Groceries"

    list_titles = user.lists.pluck(:title)
    expect(list_titles).to eq(["Groceries"]), "List should be saved to database"
  end

  scenario 'requires title' do
    user = create(:user)
    visit_new_list_page user: user

    expect(page).to have_field("List Title", with: "")
    click_button "Save"

    expect(page).to have_text "Please enter a title"
    expect(page).to be_new_list_page
    expect(List.count).to eq(0)
  end

  xscenario 'not added when user cancels' do
    # click the '< Lists' back button after filling in a title

    # Check the list is not shown in index
  end

  private

  def visit_new_list_page(user:)
    visit_login_page_and_login user: user
    click_link "+ New List"
    expect(page).to be_new_list_page
  end

  def be_new_list_page
    have_title("New List").and have_css("h1", text: "New List")
  end

end
