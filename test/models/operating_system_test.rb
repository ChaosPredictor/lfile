require 'test_helper'

class OperatingSystemTest < ActiveSupport::TestCase
	
	def setup
		@os = OperatingSystem.new(
			name: "UBUNTU", 
			version: "16.04")
	end
	
	test "should be valid" do
		assert @os.valid?
	end
	
	test "name should be present" do
		@os.name = "   "
		assert_not @os.valid?
	end
	
	test "name should not be too long" do
		@os.name = "a" * 51
		assert_not @os.valid?
	end
	
	test "email addresses should be unique" do
		duplicate_os = @os.dup
		@os.save
		assert_not duplicate_os.valid?
	end
end
