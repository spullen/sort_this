require "sortable/version"

module Sortable
end

if defined?(Rails::Railtie)
  require 'sortable/railtie'
elsif defined?(Rails::Initializer)
  raise "sortable is not compatible with Rails 2.3 or older"
end
