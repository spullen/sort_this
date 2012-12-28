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
  
  gem.add_development_dependency 'rspec', '2.12.0'
  gem.add_development_dependency 'sqlite3', '1.3.6'
  gem.add_development_dependency 'factory_girl', '4.1.0'
  gem.add_development_dependency 'database_cleaner', '0.9.1'
  gem.add_development_dependency 'capybara', '2.0.1'
  gem.add_development_dependency 'rake'
end
