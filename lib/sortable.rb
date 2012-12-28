require 'sortable/version'
require 'sortable/active_record'
require 'sortable/action_controller'
require 'sortable/view_helpers/action_view'
require 'sortable/railtie' if defined?(Rails)

module Sortable
  SORT_ASC                = 'ASC'
  SORT_DESC               = 'DESC'
  DEFAULT_SORT_DIRECTION  = SORT_ASC
  VALID_SORT_DIRECTIONS   = [SORT_ASC, SORT_DESC]
end
