require 'action_view'

module Sortable
  module ViewHelpers
    module ActionView
      
      def sortable(column, title = nil, html_options = {})
        title ||= column.titleize
        css_class = (column == sort_column) ? "sortable-current sortable-#{sort_direction}" : nil
        direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
        link_to title, params.merge(:sort => column, :direction => direction), {:class => css_class}.merge(html_options)
      end
      
    end
  end
end