class EmberBuilder
  include Singleton

  def initialize
    @build_count = 0
  end

  def build_once
    build if @build_count == 0
  end

  def build
    puts "----------------------------------------------"
    puts "Building Ember test environment..."
    system "bin/ember build --environment=test"
    puts "...completed building Ember test environment"
    puts "----------------------------------------------"
    @build_count += 1
  end

  def self.build_once
    instance.build_once
  end
end

RSpec.configure do |config|

  config.before(:each, type: :feature) do
    EmberBuilder.build_once
  end

end