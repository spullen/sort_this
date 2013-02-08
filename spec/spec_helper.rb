require 'sqlite3'
require 'active_record'
require 'factory_girl'
require 'database_cleaner'
require 'capybara'
require 'rspec'

require 'sort_this'

Dir[File.expand_path("support/**/*.rb", File.dirname(__FILE__))].each {|f| require f}

FactoryGirl.find_definitions

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end