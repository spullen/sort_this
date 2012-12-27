module Sortable
  module ActiveRecord
    SORT_ASC                = 'ASC'
    SORT_DESC               = 'DESC'
    DEFAULT_SORT_DIRECTION  = SORT_ASC
    VALID_SORT_DIRECTIONS   = [SORT_ASC, SORT_DESC]
    
    def self.included(base)
      base.class_eval do
        extend ClassMethods
        class_attribute :sort_columns, :default_sort_columns
      end
    end
  
    module ClassMethods
      
      def sortable(*sorts)
        
      end
      
      def sort(sort_column = nil, sort_direction = DEFAULT_SORT_DIRECTION)
        query = scoped
    
        # sanitize the sort column and direction
        sort_column     = sort_column.to_s.downcase.to_sym
        sort_direction  = sort_direction.upcase
        sort_direction  = (VALID_SORT_DIRECTIONS.include?(sort_direction) ? sort_direction : DEFAULT_SORT_DIRECTION)
        
        table_joins   = []
        order_clauses = []
        
        if !sort_column.blank? && sort_columns.include?(sort_column)      
          join = sort_columns[sort_column][:joins]
          table_joins   << join unless join.nil?
          order_clauses << "#{sort_columns[sort_column][:clause]} #{sort_direction}"
        end
        
        default_sorts = default_sort_columns.clone
        default_sorts.delete(sort_column) unless sort_column.blank? # remove the sort column's default if it exists
        
        default_sorts.each do |column_name, sort_clause|
          join = sort_columns[column_name][:joins]
          tables_joins  << join unless join.nil?
          order_clauses << sort_clause
        end
        
        table_joins.uniq!
        query = query.joins(table_joins) unless table_joins.empty?
        
        query = query.order(order_clauses.join(', '))
        
        query
      end
      
    end
  end
end