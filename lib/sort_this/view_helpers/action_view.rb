require 'action_view'

module SortThis
  module ViewHelpers
    module ActionView
      
      def sortable(sort_name, title = nil, html_options = {})
        title ||= sort_name.titleize
        css_class = (sort_name == sort_column) ? "sortable-current sortable-#{sort_direction}" : nil
        direction = (sort_name == sort_column && sort_direction == "asc") ? "desc" : "asc"
        link_to title, params.merge(:sort => sort_name, :direction => direction), {:class => css_class}.merge(html_options)
      end
      
    end
  end
end