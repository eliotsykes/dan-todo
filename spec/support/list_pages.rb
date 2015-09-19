module ListPages

  def visit_edit_list_page(user:, list:)
    visit_login_page_and_login user: user
    expect(page).to be_lists_page
    click_link "Edit"
    click_link "Edit List"
    expect(page).to be_edit_list_page(list)
  end

  def be_lists_page
    have_heading("Your Lists")
  end

  def be_new_list_page
    have_heading("New List")
  end

  def be_edit_list_page(list=nil)
    expected_title = list ? list.title : ""
    have_heading("Edit List").and have_field("List Title", with: expected_title)
  end

  private

  def have_heading(heading)
    have_title(heading).and have_css("h1", text: heading)
  end

end

RSpec.configure do |config|
  config.include ListPages, type: :feature
end
