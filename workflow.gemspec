# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'workflow/version'

Gem::Specification.new do |spec|
  spec.name          = 'workflow'
  spec.version       = Workflow::VERSION
  spec.authors       = ['Dmitry Kovalevsky']
  spec.email         = ['kovalevsky@setka.io']

  spec.summary       = %q{Ruby client for Workflow Integration API}
  spec.homepage      = %q{https://github.com/setkaio/workflow-ruby}
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'faraday', '~> 0.9'
  spec.add_dependency 'faraday_middleware'

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'pry-byebug'
end
