require 'spec_helper'

class TestController < AbstractController::Base
  include Sortable::ActionController
end

# get access to the protected methods
TestController.send(:public, *TestController.protected_instance_methods)

describe Sortable::ActionController do
  
  it 'should respond to sortable' do
    TestController.should respond_to(:sortable)
  end
  
  describe 'instance methods' do
  
    before(:each) do
      @controller = TestController.new
    end
    
    it 'should respond to sort_column' do
      @controller.should respond_to(:sort_column)
    end
    
    it 'should respond to sort_direction' do
      @controller.should respond_to(:sort_direction)
    end
  
  end
end
