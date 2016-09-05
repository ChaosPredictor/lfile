require 'test_helper'

class InstallationTest < ActiveSupport::TestCase
  def setup
		@user = users(:michael)
		@line = Line.first
		@installation  = Installation.new(name: "R", version: "1.1", os: "Linux", source_link: "web1.com", user_id: 1)
		@installation2 = Installation.new(name: "R", version: "2.1", os: "New", source_link: "web2.com")
	end
	
	test "should be valid" do
		assert @installation.valid?
	end
	
	test "name should be present" do
		@installation.name = " "
		assert_not @installation.valid?
	end
	
	test "user id should be present" do
		@installation.user_id = nil
		assert_not @installation.valid?
	end
	
	test "name should not be too long" do
		@installation.name = "a" * 51
		assert_not @installation.valid?
	end
	
	test "version should be present" do
		@installation.version = ""
		assert_not @installation.valid?
	end
	
	test "version should not be too long" do
		@installation.version = "a" * 21
		assert_not @installation.valid?
	end
	
	test "source link should not be too long" do
		@installation.source_link = "a" * 129
		assert_not @installation.valid?
	end
	
	test "user id should not be nil" do
		@installation.user_id = nil
		assert_not @installation.valid?
	end

	test "user id should be user id" do
		@installation.user_id = @user.id
		assert @installation.valid?
	end	
	
	test "name should be unique" do
		duplicate_installation = @installation.dup
		duplicate_installation.name = @installation.name
		@installation.save
		assert_not duplicate_installation.valid?
		@installation2.save
		assert_not duplicate_installation.valid?		
	end
	
	
end
