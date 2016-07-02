require 'test_helper'

class StepTest < ActiveSupport::TestCase
  
	def setup
		@step = Step.new(instalation_id: 1, line_id: 1, order: 1)
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
	
	test "should include and exclude line from instalation" do
		instalation = instalations(:gimp)
		line = lines(:first)
		assert_not instalation.hasline?(line)
		instalation.addline(line)
		assert instalation.hasline?(line)
		instalation.removeline(line)
		assert_not instalation.hasline?(line)
	end
end
