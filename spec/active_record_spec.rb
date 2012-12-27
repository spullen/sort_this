require 'spec_helper'

describe Sortable::ActiveRecord do
  
  it 'should have a sortable class method' do
    Quote.methods.include?(:sortable).should be_true
  end
  
  it 'should have a sort class method' do
    Quote.methods.include?(:sort).should be_true
  end
  
  describe '.sortable' do
    
    context 'given no parameters' do
      before(:each) do
        Quote.sortable()
      end
    
      it 'should set sort_columns to an empty hash' do
        Quote.sort_columns.should == {}
      end
      
      it 'should set default_sort_columns to an empty hash' do
        Quote.default_sort_columns.should == {}
      end
    end
    
    context 'given a sort column with just the required sort options' do
      before(:each) do
        Quote.sortable :price => {:column_name => :price}
      end
      
      it 'should set the sort_columns options for the specified sort name' do
        Quote.sort_columns.should have_key(:price)
      end
      
      describe 'sort_columns for the specified sort name' do
        it 'should properly set the column_name option' do
          Quote.sort_columns[:price][:column_name].should == :price
        end
        
        it 'should properly set the default option' do
          Quote.sort_columns[:price][:default].should be_nil
        end
        
        it 'should properly set the joins option' do
          Quote.sort_columns[:price][:joins].should be_nil
        end
        
        it 'should properly set the clause option' do
          Quote.sort_columns[:price][:clause].should == "quotes.price"        
        end
      end
      
      it 'should set default_sort_columns to an empty hash' do
        Quote.default_sort_columns.should == {}
      end
    end
    
  end
  
  describe '.sort' do
  
  end
  
end
