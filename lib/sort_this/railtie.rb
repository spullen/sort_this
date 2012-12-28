module SortThis
  class Railtie < Rails::Railtie
    initializer 'sortable' do |app|
      ActiveSupport.on_load :active_record do
        include SortThis::ActiveRecord
      end
      
      ActiveSupport.on_load :action_controller do
        include SortThis::ActionController
        helper_method :sort_column, :sort_direction
      end
      
      ActiveSupport.on_load :action_view do
        include SortThis::ViewHelpers::ActionView
      end
    end
  end
end