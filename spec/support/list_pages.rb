module ListPages

  def be_lists_page
    have_heading("Your Lists")
  end

  def be_new_list_page
    have_heading("New List")
  end

  def be_edit_list_page(list)
    have_heading("Edit List").and have_field("List Title", with: list.title)
  end

  private

  def have_heading(heading)
    have_title(heading).and have_css("h1", text: heading)
  end

end

RSpec.configure do |config|
  config.include ListPages, type: :feature
end
