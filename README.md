# Sortable

[the idea/scratch work](https://gist.github.com/e8dbf5c651f6744faeda)

## Installation

Add this line to your application's Gemfile:

    gem 'sortable', :git => 'git://github.com/spullen/sortable.git'

And then execute:

    $ bundle

## Usage

### Model

Add a call to the `sortable` method with a hash of sorts

    class YourModel < ActiveRecord::Base
      
      sortable :sort_name => {:column_name => :name, :default => 'ASC', :joins => :association, :clause => "some.clause"}
      
    end
    
The options are

    sort_name: Is the name of the sort, this in most cases will be the same as the column_name, but can be anything
    
    Sort Options:
    
      column_name: (Required) The name of the column to sort on.
      default:     (Optional) Defines a default sort if provided. The valid options are 'ASC' or 'DESC'.
      joins:       (Optional) Defines an association to join on, this should be provided if the column is in another table.
      clause:      (Optional) Overrides the clause used for the sort.
      
Then to sort

    YourModel.sort("sort_name", "asc|desc") => sorted list of YourModel objects
    
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

- Add error handling to active record sortable
- Add the ability to customize the sort and direction parameters
- Define scopes for each sort defined (individual sort scopes)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
