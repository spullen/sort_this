# SortThis [![Build Status](https://secure.travis-ci.org/spullen/sort_this.png)](http://travis-ci.org/spullen/sort_this)

SortThis provides a way to sort.

The controller/view code is based off of railscasts [episode 228 - Sortable Table Columns](http://railscasts.com/episodes/228-sortable-table-columns).

Here is an [example app](https://github.com/spullen/sort_example) that demonstrates the usage.

## Installation

Add this line to your application's Gemfile:

    gem 'sort_this'

And then execute:

    $ bundle

## Usage

### Model

Add a call to the `sortable` method with a hash of sorts

    class YourModel < ActiveRecord::Base
      
      sort_this :sort_name => {:column_name => :name, :default => 'ASC', :table_name => 'some_other_table_name', :joins => :association, :clause => "some.clause"}
      
    end
    
The options are

    sort_name: Is the name of the sort, this in most cases will be the same as the column_name, but can be anything
    
    Sort Options:
    
      column_name: (Optional) The name of the column to sort on. If left blank it will use the sort name.
      default:     (Optional) Defines a default sort if provided. The valid options are 'ASC' or 'DESC'.
      table_name:  (Optional) Overrides the table name used, should usually be used in coordination with joins.
      joins:       (Optional) Defines an association to join on, this should be provided if the column is in another table. ** Requires table name to be set. **
                              This is what you would usually pass into a joins or includes clause for ActiveRecord.
      clause:      (Optional) Overrides the clause used for the sort.
      
Then to sort

    YourModel.sort("sort_name", "asc|desc|ASC|DESC") => sorted list of YourModel objects
    
### Controller

In you controller define a default sort

    class SomeController < ApplicationController
      sortable "sort_name"
      
      def index
        SomeModel.sort(sort_column, sort_direction)
      end
    end
    
### In Views

    sortable(sort_name, title = nil, html_options = {})
    
    <%= sortable("sort_name") %>
    
    or custom title

    <%= sortable("sort_name", "Sort Different Name") %>
    
## TODO:

Defined Highest to Lowest priority

- Options on the `sortable` controller options
    - Limiting which actions it can be applied on
    - Allowing different types of sorts for different actions (defining multiple sortables)
    - Customized sort parameters
- Test helpers to verify that sorts have been declared properly
- Being able to define multiple column sorts

      Something like:
      sort_this :some_crazy_sort => {
        [
          {:column_name => :some_column, other options},
          ...
        ] 
      }
    
      not sure how that'd be called though...

- Throw error when the table_name option is not set and joins is set.
- Define a default scope and remove from the sort method, gives more control to developer.
- Define scopes for each sort defined (individual sort scopes)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
