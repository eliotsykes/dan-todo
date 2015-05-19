class EmberBuilder
  include Singleton

  def initialize
    @build_count = 0
  end

  def build_once
    build if @build_count == 0
  end

  def build
    p "TODO: bin/ember build --environment=test"
    p "...and wait until it completes (print time output? --quiet option?)"
    @build_count += 1
  end

  def self.build_once
    instance.build_once
  end
end

RSpec.configure do |config|

  config.before(:each, type: :feature) do
    # Assume JavaScript required if the capybara driver is JS-capable. All drivers
    # except :rack_test are assumed to be JS-capable. Saves time by not running
    # Ember build when selected feature specs that don't require JS are run.
    #
    # Testing current_driver is more dependable than testing for js:true as 
    # Capybara allows driver to be set with `driver: :selenium` meta data.
    js_required = Capybara.current_driver != :rack_test
    EmberBuilder.build_once if js_required
  end

end