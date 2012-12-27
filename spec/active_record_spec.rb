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
    
  end
  
  describe '.sort' do
  
  end
  
end
