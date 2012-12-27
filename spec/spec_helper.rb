require 'debugger'
require 'sqlite3'
require 'active_record'
require 'rspec'

require 'sortable'

Dir[File.expand_path("support/**/*.rb", File.dirname(__FILE__))].each {|f| require f}

RSpec.configure do |config|
  config.before(:suite) do
    setup_db
  end
  
  config.after(:suite) do
    teardown_db
  end
end
