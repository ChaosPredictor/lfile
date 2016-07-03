require 'test_helper'

class LineTest < ActiveSupport::TestCase
  def setup
		@line = Line.new(content: "sudo apt-get update", index: 0)
		@instalation = instalations(:gimp)
		@line2 = @instalation.lines.build(content: "line for test", index: 1)
	end

	test "should be valid" do
		assert @line.valid?
		assert @line2.valid?		
	end
	
	test "content should be present" do
		@line.content = " "
		assert_not @line.valid?
	end
	
	test "content should not be too long" do
		@line.content = "a" * 1025
		assert_not @line.valid?
	end
	
	test "index should be present" do
		@line.index = nil
		assert_not @line.valid?
	end
	
	test "index should be integer" do
		@line.index = "a"
		assert_not @line.valid?
	end
	
	test "index should not be too big or too small" do
		@line.index = 4096
		assert @line.valid?
		@line.index = -4096
		assert @line.valid?
		
		@line.index = 4097
		assert_not @line.valid?
		@line.index = -4097
		assert_not @line.valid?
	end
end
