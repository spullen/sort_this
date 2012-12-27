require 'sortable'

module Sortable
  class Railtie < Rails::Railtie
    initializer 'sortable' do |app|
      ActiveSupport.on_load :active_record do
        require 'sortable/active_record'
      end
      
      ActiveSupport.on_load :action_controller do
        require 'sortable/action_controller'
      end
      
      ActiveSupport.on_load :action_view do
        require 'sortable/action_view'
      end
    end
  end
end