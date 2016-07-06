require 'test_helper'

class LineTest < ActiveSupport::TestCase
  def setup
		@line = Line.new(content: "sudo apt-get update3", index: 20)
		@line2 = Line.new(content: "line for test", index: 21)
		@line3 = Line.new(content: "line for test3", index: 22)		
		@instalation = instalations(:gimp)
	end

	test "should be valid" do
		assert @line.valid?
		assert @line2.valid?
		assert @line3.valid?		
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
	
	test "content must be unique" do
		duplicate_line = @line.dup
		duplicate_line.index = @line.index + 1
		@line.save
		assert_not duplicate_line.valid?
	end
	
	test "index must be unique" do
		duplicate_line = @line.dup
		duplicate_line.content = @line.content + "a"
		@line.save
		assert_not duplicate_line.valid?
	end
end