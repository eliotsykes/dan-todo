module LoginHelper

  def logout
    visit '/logout'
    expect(page).to have_content 'You have been logged out.'
  end

end

RSpec.configure do |config|

  config.include LoginHelper, type: :feature

  config.before(:each, type: :feature) do
    logout
  end

end
