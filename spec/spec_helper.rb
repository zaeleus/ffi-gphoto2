require 'bundler/setup'
require 'gphoto2'

Dir[File.join(__dir__, 'support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'

  config.before do
    [FFI::GPhoto2, FFI::GPhoto2Port].each do |klass|
      klass.instance_methods.each do |method|
        klass.stub(method).and_return(FFI::GPhoto2Port::GP_OK)
      end
    end
  end
end
