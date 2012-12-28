# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sort_this/version'

Gem::Specification.new do |gem|
  gem.name          = "sort_this"
  gem.version       = SortThis::VERSION
  gem.authors       = ["Scott Pullen"]
  gem.email         = ["s.pullen05@gmail.com"]
  gem.description   = %q{SortThis}
  gem.summary       = %q{SortThis}
  gem.homepage      = "https://github.com/spullen/sort_this"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  
  gem.add_dependency 'rails', '>= 3.0'
  gem.add_dependency 'memoist', '0.2.0'
end
