# module Capybara
#
#   def self.javascript_supported?
#     !javascript_unsupported?
#   end
#
#   def self.javascript_unsupported?
#     drivers_without_javascript_support.include?(Capybara.current_driver.class)
#   end
#
#   private
#
#   def self.drivers_without_javascript_support
#     if !@drivers_without_javascript_support
#       @drivers_without_javascript_support = [Capybara::RackTest::Driver]
#       if defined? Capybara::Mechanize::Driver
#         @drivers_without_javascript_support << Capybara::Mechanize::Driver
#       end
#     end
#     @drivers_without_javascript_support
#   end
#
# end
