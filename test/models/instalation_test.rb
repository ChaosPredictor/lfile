require 'test_helper'

class InstalationTest < ActiveSupport::TestCase
  def setup
		@user = users(:michael)
		@line = Line.first
		@instalation  = Instalation.new(name: "R", version: "1.1", os: "Linux", source_link: "web1.com", user_id: 1)
		@instalation2 = Instalation.new(name: "R", version: "2.1", os: "New", source_link: "web2.com")
	end
	
	test "should be valid" do
		assert @instalation.valid?
	end
	
	test "name should be present" do
		@instalation.name = " "
		assert_not @instalation.valid?
	end
	
	test "user id should be present" do
		@instalation.user_id = nil
		assert_not @instalation.valid?
	end
	
	test "name should not be too long" do
		@instalation.name = "a" * 51
		assert_not @instalation.valid?
	end
	
	test "version should be present" do
		@instalation.version = ""
		assert_not @instalation.valid?
	end
	
	test "version should not be too long" do
		@instalation.version = "a" * 21
		assert_not @instalation.valid?
	end
	
	test "source link should not be too long" do
		@instalation.source_link = "a" * 129
		assert_not @instalation.valid?
	end
	
	test "user id should not be nil" do
		@instalation.user_id = nil
		assert_not @instalation.valid?
	end

	test "user id should be user id" do
		@instalation.user_id = @user.id
		assert @instalation.valid?
	end	
	
	test "name should be unique" do
		duplicate_instalation = @instalation.dup
		duplicate_instalation.name = @instalation.name
		@instalation.save
		assert_not duplicate_instalation.valid?
		@instalation2.save
		assert_not duplicate_instalation.valid?		
	end
	
	
end
