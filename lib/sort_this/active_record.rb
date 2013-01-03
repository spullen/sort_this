require 'memoist'
require 'active_record'

module SortThis
  module ActiveRecord
    def self.included(base)
      base.class_eval do
        extend ClassMethods
        
        class << self; extend Memoist; self; end.memoize :sort
        
        class_attribute :sort_columns, :default_sort_columns
      end
    end
  
    module ClassMethods
       
      #
      # Input is a hash of sort_name => sort_options pairs
      #
      # :column_name  => (required) Column name to sort on
      # :default      => (optional) 'ASC'|'DESC'
      # :joins        => (optional) Association to join on. Note: must be an association of the model being sorted.
      #                             Prefixes the column_name with the table name to prevent collisions
      # :clause       => (optional) Override the clause of the sort
      #
      # ex.
      # products  have many  quotes
      # vendors   have many  quotes
      #
      # sorting on the quotes table
      #
      # :sort_name1 => { :column_name => :quantity }
      # :sort_name2 => { :column_name => :price, :default => 'DESC' }
      # :sort_name3 => { :column_name => :name, :joins => :product }
      #
      def sort_this(sorts = {})
        self.sort_columns = {}
        self.default_sort_columns = {}
        
        empty_sort_options = { :column_name => nil, :default => nil, :joins => nil, :clause => nil }
        
        sorts.each do |sort_name, sort_options|
          sort_options = empty_sort_options.merge(sort_options)
          
          self.sort_columns[sort_name] = sort_options
          
          column  = sort_options[:column_name]
          
          raise SortThisError, "column_name option for #{sort_name} is required." if column.blank?
          
          table   = (sort_options[:joins].blank?)   ? table_name            : sort_options[:joins].to_s.pluralize
          clause  = (sort_options[:clause].blank?)  ? "#{table}.#{column}"  : sort_options[:clause]
          
          self.sort_columns[sort_name][:clause] = clause if sort_options[:clause].blank?
          
          unless sort_options[:default].blank?
            default_sort_direction = sort_options[:default].upcase
            
            unless VALID_SORT_DIRECTIONS.include?(default_sort_direction)
              raise SortThisError, "Invalid sort direction for: #{sort_name}. Must be 'ASC'/'asc' or 'DESC'/'desc'."
            end   
            
            self.default_sort_columns[sort_name] = "#{clause} #{default_sort_direction}"
          end
        end
      end
      
      def default_sort
        order(self.default_sort_columns.values.join(', '))
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