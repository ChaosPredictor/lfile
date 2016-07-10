require 'test_helper'

class StepTest < ActiveSupport::TestCase
  
	def setup
		@step = Step.new(instalation_id: 1, line_id: 1, order: 1)
		@instalation = instalations(:gimp)
		@instalation2 = instalations(:firefox)
		@line = lines(:first)
		@lineb = lines(:second)
		@step1 = steps(:s1)
		@line1 = lines(:l1)
		@line2 = lines(:l2)
		@line3 = lines(:l3)
		@line4 = lines(:l4)

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
	
	test "should add and remove line from 2 instalations" do
		assert_not @instalation.line?(@line)
		assert_not @instalation.line?(@line2)
		assert_not @instalation2.line?(@line)
		assert_not @instalation2.line?(@line2)
		@instalation.addline(@line, 1)
		@instalation2.addline(@lineb, 1)
		assert @instalation.line?(@line)
		assert @instalation2.line?(@lineb)
		assert_not @instalation.line?(@lineb)
		assert_not @instalation2.line?(@line)
		@instalation.addline(@lineb, 13)
		assert @instalation.line?(@line)
		assert @instalation2.line?(@lineb)
		assert @instalation.line?(@lineb)
		assert_not @instalation2.line?(@line)
		@instalation2.addline(@line, 14)
		assert @instalation.line?(@line)
		assert @instalation2.line?(@lineb)
		assert @instalation.line?(@lineb)
		assert @instalation2.line?(@line)
		@instalation2.addline(@line, 2)
		assert @instalation.line?(@line)
		assert @instalation2.line?(@lineb)
		assert @instalation.line?(@lineb)
		assert @instalation2.line?(@line)
		#@instalation.removeline(@lineb, 2)
		#assert @instalation.line?(@line)
		#assert @instalation2.line?(@lineb)
		#assert_not @instalation.line?(@lineb)
		#assert @instalation2.line?(@line)		
	end
	
	test "should add and remove line from one instalation" do
		assert_not @instalation.line?(@line1)
		assert_not @instalation.line?(@line2)
		assert_not @instalation.line?(@line3)
		assert_not @instalation.line?(@line4)
#		assert_not @instalation.line?(@line5)
#		assert_not @instalation.line?(@line6)
#		assert_not @instalation.line?(@line7)
#		assert_not @instalation.line?(@line8)	
#		assert_not @instalation.line?(@line9)
#		assert_not @instalation.line?(@line10)
#		assert_match Step.all, "dsfgds"
#		Step.create(:step, @step1)
	end
end
