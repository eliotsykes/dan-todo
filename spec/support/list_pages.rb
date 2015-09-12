module ListPages

  def be_lists_page
    have_title("Your Lists").and have_css("h1", text: "Your Lists")
  end

  def be_new_list_page
    have_title("New List").and have_css("h1", text: "New List")
  end

end

RSpec.configure do |config|
  config.include ListPages, type: :feature
end
