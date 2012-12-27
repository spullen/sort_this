require 'spec_helper'

class TestController < ActionController::Base
  include Sortable::ActionController
  sortable "price"
  
  def index
    render :text => 'OK'
  end
end

# get access to the protected methods
TestController.send(:public, *TestController.protected_instance_methods)

describe Sortable::ActionController do
  
  it 'should respond to sortable' do
    TestController.should respond_to(:sortable)
  end
  
  it 'should set the default sort column' do
    TestController.default_sort_column.should == "price"
  end
  
  describe 'instance methods' do
    subject { @controller }
  
    before(:each) do
      @controller = TestController.new
    end
    
    it 'should respond to sort_column' do
      @controller.should respond_to(:sort_column)
    end
    
    it 'should respond to sort_direction' do
      @controller.should respond_to(:sort_direction)
    end
    
    describe '#sort_column' do
      context 'given that the sort param is not set' do
        it 'should return the default sort column' do
          @controller.stub!(:params).and_return({})
          @controller.sort_column.should == "price"
        end
      end
      
      context 'given that the sort param is set' do
        it 'should return the sort provided by the params' do
          sort = "quantity"
          @controller.stub!(:params).and_return({:sort => sort})
          @controller.sort_column.should == sort
        end
      end
    end
    
    describe '#sort_direction' do
      context 'given that the direction param is not set' do
        it 'should return the default sort direction' do
          @controller.stub!(:params).and_return({})
          @controller.sort_direction.should == "asc"
        end
      end
      
      context 'given that the direction param is set' do
        it 'should return the sort direction provided by the params' do
          @controller.stub!(:params).and_return({:direction => "desc"})
          @controller.sort_direction.should == "desc"
        end
        
        context 'when the param is invalid' do
          it 'should return the default sort direction' do
            @controller.stub!(:params).and_return({})
            @controller.sort_direction.should == "asc"
          end
        end
      end
    end
  end
end
