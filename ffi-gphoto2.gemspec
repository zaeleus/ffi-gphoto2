lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'gphoto2/version'

Gem::Specification.new do |spec|
  spec.name          = 'ffi-gphoto2'
  spec.version       = GPhoto2::VERSION
  spec.authors       = ['Michael Macias']
  spec.email         = ['mamacias@go.olemiss.edu']
  spec.summary       = %q{A Ruby FFI for common functions in libgphoto2}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 2.14.1'

  spec.add_dependency 'ffi', '~> 1.9.0'
end
