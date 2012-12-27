require 'action_controller'

module Sortable
  module ActionController
    def self.included(base)
      base.class_eval do
        extend ClassMethods
        class_attribute :default_sort_column
      end
    end
    
    module ClassMethods
    
      def sortable(sort_column)
        self.default_sort_column = sort_column
      end
      
    end
    
    protected
    
    def sort_column
      params[:sort].blank? ? self.default_sort_column : params[:sort]
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
  
  end
end