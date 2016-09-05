require 'test_helper'

class StepTest < ActiveSupport::TestCase
  
	def setup
		@step = Step.new(installation_id: 1, line_id: 1, order: 1)
		@installation = installations(:gimp)
		@installation2 = installations(:firefox)
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
	
	test "should require a installation_id" do
		@step.installation_id = nil
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
	
	test "should add and remove line from 2 installations" do
		assert_not @installation.line?(@line)
		assert_not @installation.line?(@line2)
		assert_not @installation2.line?(@line)
		assert_not @installation2.line?(@line2)
		@installation.addline(@line, 1)
		@installation2.addline(@lineb, 1)
		assert @installation.line?(@line)
		assert @installation2.line?(@lineb)
		assert_not @installation.line?(@lineb)
		assert_not @installation2.line?(@line)
		@installation.addline(@lineb, 13)
		assert @installation.line?(@line)
		assert @installation2.line?(@lineb)
		assert @installation.line?(@lineb)
		assert_not @installation2.line?(@line)
		@installation2.addline(@line, 14)
		assert @installation.line?(@line)
		assert @installation2.line?(@lineb)
		assert @installation.line?(@lineb)
		assert @installation2.line?(@line)
		@installation2.addline(@line, 2)
		assert @installation.line?(@line)
		assert @installation2.line?(@lineb)
		assert @installation.line?(@lineb)
		assert @installation2.line?(@line)
		#@installation.removeline(@lineb, 2)
		#assert @installation.line?(@line)
		#assert @installation2.line?(@lineb)
		#assert_not @installation.line?(@lineb)
		#assert @installation2.line?(@line)		
	end
	
	test "should add and remove line from one installation" do
		assert_not @installation.line?(@line1)
		assert_not @installation.line?(@line2)
		assert_not @installation.line?(@line3)
		assert_not @installation.line?(@line4)
#		assert_not @installation.line?(@line5)
#		assert_not @installation.line?(@line6)
#		assert_not @installation.line?(@line7)
#		assert_not @installation.line?(@line8)	
#		assert_not @installation.line?(@line9)
#		assert_not @installation.line?(@line10)
#		assert_match Step.all, "dsfgds"
#		Step.create(:step, @step1)
	end
end
