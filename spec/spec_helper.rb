require 'bundler/setup'
require 'gphoto2'

__dir__ ||= File.dirname(__FILE__)
Dir[File.join(__dir__, 'support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
