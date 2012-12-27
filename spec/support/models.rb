def setup_db
  puts "\nSetting up the database...\n"
  
  ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
  
  ActiveRecord::Schema.define(:version => 1) do
    create_table("products") do |t|
      t.string   "name"
    end
  
    create_table("quotes") do |t|
      t.integer  "product_id"
      t.integer  "vendor_id"
      t.decimal  "price",      :precision => 10, :scale => 2, :default => 0.0
      t.integer  "quantity",                                  :default => 0
    end
  
    create_table("vendors") do |t|
      t.string   "name"
    end
  end
end

def teardown_db
  puts "\nTearing down the database...\n"
  
  ActiveRecord::Base.connection.tables.each do |table|
    ActiveRecord::Base.connection.drop_table(table)
  end
end

class Product < ActiveRecord::Base
  has_many :quotes
end

class Vendor < ActiveRecord::Base
  has_many :quotes
end

class Quote < ActiveRecord::Base
  include Sortable::ActiveRecord

  belongs_to :product
  belongs_to :vendor
  
  sortable :price         => {:column_name => :price, :default => 'ASC'},
           :quantity      => {:column_name => :quantity},
           :product_name  => {:column_name => :name, :joins => :product},
           :vendor_name   => {:column_name => :name, :joins => :vendor}
end