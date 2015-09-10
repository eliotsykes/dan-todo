require 'rails_helper'

feature 'New list', type: :feature, js: true do

  scenario 'added successfully' do
    user = create(:user)
    visit_login_page_and_login user: user

    click_link "+ New List"

    expect(page).to have_title "New List"
    expect(page).to have_css "h1", text: "New List"

    fill_in "List Title", with: "Groceries"
    click_button "Save"

    expect(page).to have_text "New list saved successfully."
    expect(page).to have_title "Your Lists"
    expect(page).to have_css "h1", text: "Your Lists"
    expect(page).to have_css "li", text: "Groceries"

    list_titles = user.lists.pluck(:title)
    expect(list_titles).to eq(["Groceries"]), "List should be saved to database"
  end

  xscenario 'requires title' do
    # show error message
  end

  xscenario 'not added when user cancels' do
    # click the '< Lists' back button after filling in a title

    # Check the list is not shown in index
  end



end
