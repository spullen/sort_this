require 'spec_helper'

describe SortThis::ActiveRecord do

  before(:all) do
    setup_db
    DatabaseCleaner.strategy = :truncation
  end
  
  after(:all) do
    teardown_db
  end
  
  before(:each) do
    DatabaseCleaner.start
  end

  after(:each) do
    DatabaseCleaner.clean
  end
  
  it 'should have a sort_this class method' do
    Quote.should respond_to(:sort_this)
  end
  
  it 'should have a sort class method' do
    Quote.should respond_to(:sort)
  end
  
  describe '.sort_this' do
  
    shared_examples_for 'sort_columns_defined' do
      it 'should set the sort_columns options for the specified sort name' do
        Quote.sort_columns.should have_key(sort_name)
      end
      
      describe 'sort_columns for the specified sort name' do
        it 'should properly set the column_name option' do
          Quote.sort_columns[sort_name][:column_name].should == column_name_option
        end
        
        it 'should properly set the default option' do
          Quote.sort_columns[sort_name][:default].should == default_option
        end
        
        it 'should properly set the table_name' do
          Quote.sort_columns[sort_name][:table_name].should == table_name_option
        end
        
        it 'should properly set the joins option' do
          Quote.sort_columns[sort_name][:joins].should == joins_option
        end
        
        it 'should properly set the clause option' do
          Quote.sort_columns[sort_name][:clause].should == clause_option      
        end
      end
    end
    
    context 'given no parameters' do
      before(:each) do
        Quote.sort_this()
      end
    
      it 'should set sort_columns to an empty hash' do
        Quote.sort_columns.should == {}
      end
      
      it 'should set default_sort_columns to an empty hash' do
        Quote.default_sort_columns.should == {}
      end
    end
    
    context 'given a sort column with no options specified' do
      let!(:sort_name)          { :price }
      let!(:column_name_option) { :price }
      let!(:table_name_option)  { 'quotes' }
      let!(:default_option)     { nil }
      let!(:joins_option)       { nil }
      let!(:clause_option)      { "quotes.price" }
      
      before(:each) do
        Quote.sort_this sort_name => {}
      end
      
      it_should_behave_like 'sort_columns_defined'
      
      it 'should set default_sort_columns to an empty hash' do
        Quote.default_sort_columns.should == {}
      end
    end
    
    context 'given a sort column with just the required sort options' do
      let!(:sort_name)          { :price }
      let!(:column_name_option) { :price }
      let!(:table_name_option)  { 'quotes' }
      let!(:default_option)     { nil }
      let!(:joins_option)       { nil }
      let!(:clause_option)      { "quotes.price" }
    
      before(:each) do
        Quote.sort_this sort_name => {:column_name => column_name_option}
      end
      
      it_should_behave_like 'sort_columns_defined'
      
      it 'should set default_sort_columns to an empty hash' do
        Quote.default_sort_columns.should == {}
      end
    end
    
    context 'given a sort column with a default specified in the sort options' do
      context 'when the default is valid' do
        let!(:sort_name)          { :price }
        let!(:column_name_option) { :price }
        let!(:table_name_option)  { 'quotes' }
        let!(:default_option)     { 'DESC' }
        let!(:joins_option)       { nil }
        let!(:clause_option)      { "quotes.price" }
      
        before(:each) do
          Quote.sort_this sort_name => {:column_name => column_name_option, :default => default_option}
        end
        
        it_should_behave_like 'sort_columns_defined'
        
        it 'should set the default_sort_columns options for the specified sort name' do
          Quote.default_sort_columns.should have_key(sort_name)
        end
        
        it 'should set the clause of the default_sort_columns for the specified sort name' do
          Quote.default_sort_columns[sort_name].should == "#{clause_option} #{default_option}"
        end
      end
      
      context 'when the default is not ASC or DESC' do
        let!(:sort_name)          { :quantity }
        let!(:column_name_option) { :quantity }
        let!(:table_name_option)  { 'quotes' }
        let!(:default_option)     { 'GARBAGE' }
        let!(:joins_option)       { nil }
        let!(:clause_option)      { "custom.joins_clause" }
      
        it 'should raise a SortThisError' do
          lambda {
            Quote.sort_this sort_name => {:column_name => column_name_option, :default => default_option, :clause => clause_option}
          }.should raise_error(SortThis::SortThisError, "Invalid sort direction for: #{sort_name}. Must be 'ASC'/'asc' or 'DESC'/'desc'.")
        end
      end
    end
    
    context 'given a sort column with a joins specified in the sort options' do
      let!(:sort_name)          { :product_name }
      let!(:column_name_option) { :name }
      let!(:table_name_option)  { 'products' }
      let!(:default_option)     { nil }
      let!(:joins_option)       { :product }
      let!(:clause_option)      { "products.name" }

      before(:each) do
        Quote.sort_this sort_name => {:column_name => column_name_option, :table_name => table_name_option, :joins => joins_option}
      end
      
      it_should_behave_like 'sort_columns_defined'
      
      it 'should set default_sort_columns to an empty hash' do
        Quote.default_sort_columns.should == {}
      end
    end
    
    context 'given a sort column with a custom clause specified in the sort options' do
      let!(:sort_name)          { :price }
      let!(:column_name_option) { :price }
      let!(:table_name_option)  { 'quotes' }
      let!(:default_option)     { nil }
      let!(:joins_option)       { nil }
      let!(:clause_option)      { "custom.joins_clause" }
    
      before(:each) do
        Quote.sort_this sort_name => {:column_name => column_name_option, :clause => clause_option}
      end
      
      it_should_behave_like 'sort_columns_defined'
      
      it 'should set default_sort_columns to an empty hash' do
        Quote.default_sort_columns.should == {}
      end
    end
    
    context 'given a sort column with a custom clause and default specified in the sort options' do
      let!(:sort_name)          { :quantity }
      let!(:column_name_option) { :quantity }
      let!(:table_name_option)  { 'quotes' }
      let!(:default_option)     { 'DESC' }
      let!(:joins_option)       { nil }
      let!(:clause_option)      { "custom.joins_clause" }
    
      before(:each) do
        Quote.sort_this sort_name => {:column_name => column_name_option, :default => default_option, :clause => clause_option}
      end
      
      it_should_behave_like 'sort_columns_defined'
      
      it 'should set the default_sort_columns options for the specified sort name' do
        Quote.default_sort_columns.should have_key(sort_name)
      end
      
      it 'should set the clause of the default_sort_columns for the specified sort name' do
        Quote.default_sort_columns[sort_name].should == "#{clause_option} #{default_option}"
      end
    end
    
    context 'given a sort column where the table name is overridden' do
      context 'when the table name option is already pluralized' do
        let!(:sort_name)          { :price }
        let!(:column_name_option) { :price }
        let!(:table_name_option)  { 'some_other_tables' }
        let!(:default_option)     { nil }
        let!(:joins_option)       { nil }
        let!(:clause_option)      { "some_other_tables.price" }
        
        before(:each) do
          Quote.sort_this sort_name => {:table_name => table_name_option}
        end
        
        it_should_behave_like 'sort_columns_defined'
      end
      
      context 'when the table name option is not pluralized' do
        let!(:table_name_singular) { 'another_table' }
        
        let!(:sort_name)          { :price }
        let!(:column_name_option) { :price }
        let!(:table_name_option)  { 'another_tables' }
        let!(:default_option)     { nil }
        let!(:joins_option)       { nil }
        let!(:clause_option)      { "another_tables.price" }
        
        before(:each) do
          Quote.sort_this sort_name => {:table_name => table_name_option}
        end
        
        it_should_behave_like 'sort_columns_defined'
      end
    end
  end
  
  describe '.default_sort' do
    let!(:product1) { create(:product, :name => 'D Name') }
    let!(:product2) { create(:product, :name => 'B Name') }
    let!(:product3) { create(:product, :name => 'A Name') }
    let!(:product4) { create(:product, :name => 'C Name') }
    
    it 'should return a sorted collection given by the specified default sort' do
      Product.sort_this(:name => { :column_name => :name, :default => 'DESC' })
      Product.default_sort.should == [product1, product4, product2, product3]
    end
  end
  
  describe '.sort' do
    let!(:product1) { create(:product, :name => 'D Name') }
    let!(:product2) { create(:product, :name => 'B Name') }
    let!(:product3) { create(:product, :name => 'A Name') }
    let!(:product4) { create(:product, :name => 'C Name') }
    
    let!(:vendor1) { create(:vendor, :name => 'D Name') }
    let!(:vendor2) { create(:vendor, :name => 'B Name') }
    let!(:vendor3) { create(:vendor, :name => 'A Name') }
    let!(:vendor4) { create(:vendor, :name => 'C Name') }
    
    let!(:quote1) { create(:quote, :product => product1, :vendor => vendor4, :price => 10.55, :quantity => 4) }
    let!(:quote2) { create(:quote, :product => product3, :vendor => vendor2, :price => 9.31, :quantity => 2) }
    let!(:quote3) { create(:quote, :product => product2, :vendor => vendor1, :price => 8.25, :quantity => 10) }
    let!(:quote4) { create(:quote, :product => product4, :vendor => vendor3, :price => 15.12, :quantity => 8) } 
  
    before(:each) do
      Quote.sort_this :price         => {:column_name => :price, :default => 'ASC'},
                      :quantity      => {:column_name => :quantity},
                      :product_name  => {:column_name => :name, :table_name => 'products', :joins => :product},
                      :vendor_name   => {:column_name => :name, :table_name => 'vendors', :joins => :vendor}
    end
    
    it 'should return a relation' do
      Quote.sort.class.should == ActiveRecord::Relation
    end
    
    context 'default parameters' do
      it 'should sort by quote price ascending' do
        Quote.sort.should == [quote3, quote2, quote1, quote4]
      end
    end
    
    context 'given a sort column' do
      context 'without specifying an order' do
        it 'should sort by the specified column in ascending order' do
          Quote.sort(:quantity).should == [quote2, quote1, quote4, quote3]
        end
      end
      
      context 'specifying an order' do
        it 'should sort by the specified column in descending order' do
          Quote.sort(:quantity, 'DESC').should == [quote3, quote4, quote1, quote2]
        end
      end
    end
    
    context 'given a sort column from another table' do
      it 'should sort by the specified column in descending order' do
        Quote.sort(:product_name, 'DESC').should == [quote1, quote4, quote3, quote2]
      end
    end
  end
  
end
