require 'rails'

require 'sort_this/version'
require 'sort_this/sort_this_error'
require 'sort_this/active_record'
require 'sort_this/action_controller'
require 'sort_this/view_helpers/action_view'
require 'sort_this/railtie' if defined?(Rails)

module SortThis
  SORT_ASC                = 'ASC'
  SORT_DESC               = 'DESC'
  DEFAULT_SORT_DIRECTION  = SORT_ASC
  VALID_SORT_DIRECTIONS   = [SORT_ASC, SORT_DESC]
end
