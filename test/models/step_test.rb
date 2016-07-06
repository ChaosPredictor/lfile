require 'test_helper'

class StepTest < ActiveSupport::TestCase
  
	def setup
		@step = Step.new(instalation_id: 1, line_id: 1, order: 1)
		@instalation = instalations(:gimp)
		@instalation2 = instalations(:firefox)
		@line = lines(:first)
		@line2 = lines(:second)
	end
	
	test "should be valid" do
		assert @step.valid?
	end
	
	test "should require a instalation_id" do
		@step.instalation_id = nil
		assert_not @step.valid?
	end
	
	test "should require a line_id" do
		@step.line_id = nil
		assert_not @step.valid?
	end
	
	test "should require a order" do
		@step.order = nil
		assert_not @step.valid?
	end
	
	test "order should be integer between 0 to 100" do
		@step.order = -1
		assert_not @step.valid?
		@step.order = 101
		assert_not @step.valid?
		@step.order = 0
		assert @step.valid?
		@step.order = 100
		assert @step.valid?		
	end
	
	test "should add and remove line from instalation" do
		assert_not @instalation.line?(@line)
		assert_not @instalation.line?(@line2)
		assert_not @instalation2.line?(@line)
		assert_not @instalation2.line?(@line2)
		@instalation.addline(@line, 1)
		@instalation2.addline(@line2, 1)
		assert @instalation.line?(@line)
		assert @instalation2.line?(@line2)
		assert_not @instalation.line?(@line2)
		assert_not @instalation2.line?(@line)
		@instalation.addline(@line2, 1)
		assert @instalation.line?(@line)
		assert @instalation2.line?(@line2)
		assert @instalation.line?(@line2)
		assert_not @instalation2.line?(@line)
		@instalation2.addline(@line, 1)
		assert @instalation.line?(@line)
		assert @instalation2.line?(@line2)
		assert @instalation.line?(@line2)
		assert @instalation2.line?(@line)
		@instalation2.addline(@line, 2)
		assert @instalation.line?(@line)
		assert @instalation2.line?(@line2)
		assert @instalation.line?(@line2)
		assert @instalation2.line?(@line)
		@instalation.removeline(@line2, 2)
		assert @instalation.line?(@line)
		assert @instalation2.line?(@line2)
		assert_not @instalation.line?(@line2)
		assert @instalation2.line?(@line)		
	end
	
	test "get all lines of instalation" do
		
	end
end
