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
      
      # not sure if the action view stuff will work the same way, not see any examples
      # try ActionView::Base.send :include, Sortable::ActionView if it doesn't
      ActiveSupport.on_load :action_view do
        include Sortable::ActionView
      end
    end
  end
end