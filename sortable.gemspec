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
  
  gem.add_development_dependency 'debugger', '1.2.2'
  gem.add_development_dependency 'rspec', '2.12.0'
  gem.add_development_dependency 'sqlite3', '1.3.6'
  gem.add_development_dependency 'factory_girl', '4.1.0'
  gem.add_development_dependency 'database_cleaner', '0.9.1'
  gem.add_development_dependency 'capybara', '2.0.1'
end
