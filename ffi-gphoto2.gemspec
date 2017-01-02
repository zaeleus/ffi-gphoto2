lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'gphoto2/version'

Gem::Specification.new do |spec|
  spec.name          = 'ffi-gphoto2'
  spec.summary       = 'A Ruby FFI for common functions in libgphoto2'
  spec.homepage      = 'https://github.com/zaeleus/ffi-gphoto2'

  spec.authors       = ['Michael Macias']
  spec.email         = ['zaeleus@gmail.com']

  spec.version       = GPhoto2::VERSION
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.requirements << 'libgphoto2 >= 2.5.2'
  spec.requirements << 'libgphoto2_port >= 0.10.1'
  spec.required_ruby_version = '>= 1.9'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'rspec', '~> 3.5.0'
  spec.add_development_dependency 'yard', '~> 0.9.0'

  spec.add_dependency 'ffi', '~> 1.9.0'
end
