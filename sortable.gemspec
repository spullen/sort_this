# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sortable/version'

Gem::Specification.new do |gem|
  gem.name          = "sortable"
  gem.version       = Sortable::VERSION
  gem.authors       = ["Scott Pullen"]
  gem.email         = ["s.pullen05@gmail.com"]
  gem.description   = %q{Sortable}
  gem.summary       = %q{Sortable}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  
  gem.add_dependency 'rails', '>= 3.0'
  
  gem.add_development_dependency 'debugger'
  gem.add_development_dependency 'rspec'
end
