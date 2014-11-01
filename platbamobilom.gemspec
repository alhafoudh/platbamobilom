# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'platbamobilom/version'

Gem::Specification.new do |spec|
  spec.name          = 'platbamobilom'
  spec.version       = Platbamobilom::VERSION
  spec.authors       = ['Ahmed Al Hafoudh']
  spec.email         = ['alhafoudh@freevision.sk']
  spec.summary       = %q{platbamobilom.sk signature generation and verification}
  spec.description   = %q{This gem provides a set of helpers to generate and verify signatures of http://www.platbamobilom.sk service.}
  spec.homepage      = 'https://github.com/alhafoudh/platbamobilom'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.4.2'
  spec.add_development_dependency 'pry', '~> 0.9.12.6'
end
