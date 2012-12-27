ENV['RAILS_ENV'] = 'test'

require 'debugger'
require 'rspec'
require 'sortable'

RSpec.configure do |config|
  config.extend WithModel
end
