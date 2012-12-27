module Sortable
  class Railtie < Rails::Railtie
    initializer 'sortable' do |app|
      ActiveSupport.on_load :active_record do
        include Sortable::ActiveRecord
      end
      
      ActiveSupport.on_load :action_controller do
        include Sortable::ActionController
        helper_method :sort_column, :sort_direction
      end
      
      ActiveSupport.on_load :action_view do
        include Sortable::ActionView
      end
    end
  end
end