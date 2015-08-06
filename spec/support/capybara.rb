require 'capybara/rails'
require 'capybara/rspec'

# Increase default wait time to account for Ember app boot time:
Capybara.default_wait_time = 20.seconds
