require 'bundler/setup'
require 'gphoto2'

__dir__ ||= File.dirname(__FILE__)
Dir[File.join(__dir__, 'support/**/*.rb')].each { |f| require f }
