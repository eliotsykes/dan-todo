require 'rails_helper'

feature 'List index', type: :feature, js: true do

  scenario 'shows lists' do
    user = create(:user)
    create(:list, user: user, title: "Cleaning Supplies")
    create(:list, user: user, title: "Groceries")

    visit_login_page_and_login user: user

    expect(page).to be_lists_page
    expect(page).to have_css "li[data-list]", count: 2
    expect(page).to have_css "li[data-list]", text: "Cleaning Supplies"
    expect(page).to have_css "li[data-list]", text: "Groceries"
  end

end
