module LoginHelper

  def clear_persistent_login
    visit '/'
    execute_script('window.localStorage.clear();') if Capybara.javascript_supported?
  end

end

RSpec.configure do |config|

  config.include LoginHelper, type: :feature

  config.before(:each, type: :feature) do
    clear_persistent_login
  end

end
