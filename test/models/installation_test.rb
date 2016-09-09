require 'test_helper'

class InstallationTest < ActiveSupport::TestCase
  def setup
		@user_admin              = users(:michael)
		@user_notadmin           = users(:archer)
		@user                    = users(:lana)		
		@line = Line.first
		@installation  = Installation.create(name: "R", version: "1.1", os: "Linux", source_link: "web1.com", user_id: @user.id)		
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
		@duplicate_installation = @installation.dup
		@duplicate_installation.name = @installation.name
		@installation.save
		assert_not @duplicate_installation.valid?
		@duplicate_installation.save
		assert_not @duplicate_installation.valid?		
	end
	
	test "should edit version only" do		
		@installation = Installation.first
		assert_match @installation.name, "GIMP"
		assert_match @installation.version, "1.1"
		assert_match @installation.os, "linux"
		assert_match @installation.source_link, "gimp.com"
		@installation.update(version: "1.2")
		@installation2 = Installation.first
		assert_match @installation2.name, "GIMP"
		assert_match @installation2.version, "1.2"
		assert_match @installation2.os, "linux"
		assert_match @installation2.source_link, "gimp.com"
	end
	
	test "should edit operating system only" do		
		@installation = Installation.first
		assert_match @installation.name, "GIMP"
		assert_match @installation.version, "1.1"
		assert_match @installation.os, "linux"
		assert_match @installation.source_link, "gimp.com"
		@installation.update(os: "xos")
		@installation2 = Installation.first
		assert_match @installation2.name, "GIMP"
		assert_match @installation2.version, "1.1"
		assert_match @installation2.os, "xos"
		assert_match @installation2.source_link, "gimp.com"
	end

	test "should edit for admin user source link only" do		
		@installation = Installation.first
		assert_match @installation.name, "GIMP"
		assert_match @installation.version, "1.1"
		assert_match @installation.os, "linux"
		assert_match @installation.source_link, "gimp.com"
		@installation.update(source_link: "pmig.com")
		@installation2 = Installation.first
		assert_match @installation2.name, "GIMP"
		assert_match @installation2.version, "1.1"
		assert_match @installation2.os, "linux"
		assert_match @installation2.source_link, "pmig.com"
	end
	
	# not sure now how to emplimint it
	#test "should edit for admin user without user change" do		
	#	@installation = Installation.last
	#	assert_equal @user.id, @installation.user_id
	#	@installation.update(user_id: @user_admin.id)
	#	@installation2 = Installation.last
	#	assert_equal @user.id, @installation.user_id 
	#	assert_not_equal @user_admin.id, @installation.user_id	
	#end


end
