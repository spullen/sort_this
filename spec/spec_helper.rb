require 'debugger'
require 'sqlite3'
require 'active_record'
require 'factory_girl'
require 'database_cleaner'
require 'rspec'

require 'sortable'

Dir[File.expand_path("support/**/*.rb", File.dirname(__FILE__))].each {|f| require f}

FactoryGirl.find_definitions

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    setup_db
    DatabaseCleaner.strategy = :truncation
  end
  
  config.after(:suite) do
    teardown_db
  end
  
  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
