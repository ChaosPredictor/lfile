require 'test_helper'

class InstallationsControllerTest < ActionController::TestCase
	def setup
		@installation      = installations(:gimp)
		@user_admin       = users(:michael)
		@user_notadmin    = users(:archer)		
	end
	
  test "should create new only if login" do
		#get :new
		assert_no_difference 'Installation.count' do
			post :create, installation: { name: "Lorem", version: "1.1", os: "new", source_link: "google.com" }
		end
		assert_response :redirect
		assert_redirected_to login_url
		log_in_as(@user_admin)
		#get :new
		assert_difference 'Installation.count' do
			post :create, installation: { name: "Lorem", version: "1.1", os: "new", source_link: "google.com" }
		end
		assert_equal flash[:success], "New Installation Saved!!!"
		assert_response :redirect
		assert_redirected_to installations_path
		@installation2 = Installation.last
		assert_match @installation2.name, "Lorem"
		assert_match @installation2.version, "1.1"
		assert_match @installation2.os, "new"
		assert_match @installation2.source_link, "google.com"
		assert_equal @installation2.user_id, @user_admin.id
  end
	
	test "should create when admin" do
		log_in_as(@user_admin)
		assert_difference 'Installation.count', 1 do
			post :create, installation: { name: "Lorem", version: "1.1", os: "new", source_link: "google.com" }
		end
		assert_redirected_to installations_path
		@installation2 = Installation.last
		assert_match @installation2.name, "Lorem"
		assert_match @installation2.version, "1.1"
		assert_match @installation2.os, "new"
		assert_match @installation2.source_link, "google.com"
		assert_equal @installation2.user_id, @user_admin.id
	end
	
	test "should create when logged in" do
		log_in_as(@user_notadmin)
		assert_difference 'Installation.count', 1 do
			post :create, installation: { name: "Lorem", version: "1.1", os: "new", source_link: "google.com" }
		end
		assert_redirected_to installations_path
		@installation2 = Installation.last
		assert_match @installation2.name, "Lorem"
		assert_match @installation2.version, "1.1"
		assert_match @installation2.os, "new"
		assert_match @installation2.source_link, "google.com"
		assert_equal @installation2.user_id, @user_notadmin.id
	end
		
	test "should redirect create when not logged in" do
		assert_no_difference 'Installation.count' do
			post :create, installation: { name: "Lorem", version: "1.1", os: "new", source_link: "google.com", user_id: 1 }
		end
		assert_redirected_to login_url
	end
	
	test "should redirect destroy when not logged in" do
		assert_no_difference 'Installation.count' do
			delete :destroy, id: @installation
		end
		assert_redirected_to login_url
	end
	
	test "should redirect destroy for not admin user" do
		log_in_as(@user_notadmin)
		installation = installations(:firefox)
		assert_no_difference 'Installation.count' do
			delete :destroy, id: installation
		end
		assert_redirected_to root_url
	end
	
	test "should destroy for admin user" do		
		log_in_as(@user_admin)
		@installation = installations(:gimp)
		assert_difference 'Installation.count', -1 do
			delete :destroy, id: @installation
		end
		assert_redirected_to installations_path
	end
	
	test "should edit for admin user" do		
		log_in_as(@user_admin)
		@installation = Installation.first
		assert_match @installation.name, "GIMP"
		assert_match @installation.version, "1.1"
		assert_match @installation.os, "linux"
		assert_match @installation.source_link, "gimp.com"
		assert_equal @installation.user_id, 1		
		assert_no_difference 'Installation.count' do
			patch :update, id: @installation, installation: {name: "PIMG",
																											version: "1.2",
																											os: "xos",
																											source_link: "pmig.com",
																											user_id: @user_admin.id}
		end
		assert_redirected_to installations_path
		@installation2 = Installation.first
		assert_match @installation2.name, "PIMG"
		assert_match @installation2.version, "1.2"
		assert_match @installation2.os, "xos"
		assert_match @installation2.source_link, "pmig.com"
		assert_equal @installation.user_id, 1
		assert_not_equal @installation.user_id, @user_admin.id
	end
	
	
	test "should edit for admin user version only" do		
		log_in_as(@user_admin)
		@installation = Installation.first
		assert_match @installation.name, "GIMP"
		assert_match @installation.version, "1.1"
		assert_match @installation.os, "linux"
		assert_match @installation.source_link, "gimp.com"
		assert_no_difference 'Installation.count' do
			patch :update, id: @installation, installation: {version: "1.2"}
		end
		assert_redirected_to installations_path
		@installation2 = Installation.first
		assert_match @installation2.name, "GIMP"
		assert_match @installation2.version, "1.2"
		assert_match @installation2.os, "linux"
		assert_match @installation2.source_link, "gimp.com"
	end
	
	test "should edit for admin user os only" do		
		log_in_as(@user_admin)
		@installation = Installation.first
		assert_match @installation.name, "GIMP"
		assert_match @installation.version, "1.1"
		assert_match @installation.os, "linux"
		assert_match @installation.source_link, "gimp.com"
		assert_no_difference 'Installation.count' do
			patch :update, id: @installation, installation: {os: "xos"}
		end
		assert_redirected_to installations_path
		@installation2 = Installation.first
		assert_match @installation2.name, "GIMP"
		assert_match @installation2.version, "1.1"
		assert_match @installation2.os, "xos"
		assert_match @installation2.source_link, "gimp.com"
	end
	
	test "should edit for admin user source link only" do		
		log_in_as(@user_admin)
		@installation = Installation.first
		assert_match @installation.name, "GIMP"
		assert_match @installation.version, "1.1"
		assert_match @installation.os, "linux"
		assert_match @installation.source_link, "gimp.com"
		assert_no_difference 'Installation.count' do
			patch :update, id: @installation, installation: {source_link: "pmig.com"}
		end
		assert_redirected_to installations_path
		@installation2 = Installation.first
		assert_match @installation2.name, "GIMP"
		assert_match @installation2.version, "1.1"
		assert_match @installation2.os, "linux"
		assert_match @installation2.source_link, "pmig.com"
	end
	
	test "should edit for admin user without user change" do		
		log_in_as(@user_admin)
		@installation = Installation.first
		assert_equal @installation.user_id, 1
		assert_no_difference 'Installation.count' do
			patch :update, id: @installation, installation: {user_id: @user_admin.id}
		end
		assert_redirected_to installations_path
		@installation2 = Installation.first
		assert_equal @installation.user_id, 1
		assert_not_equal @installation.user_id, @user_admin.id		
	end
	
	test "should not edit for not admin user" do		
		log_in_as(@user_notadmin)
		@installation = Installation.first
		assert_match @installation.name, "GIMP"
		assert_no_difference 'Installation.count' do
			patch :update, id: @installation, installation: {name: "PIMG"}
		end
		assert_redirected_to root_path
		@installation2 = Installation.first
		assert_match @installation2.name, "GIMP"
	end
	
	test "should not edit for not logedin" do		
		@installation = Installation.first
		assert_match @installation.name, "GIMP"
		assert_no_difference 'Installation.count' do
			patch :update, id: @installation, installation: {name: "PIMG"}
		end
		assert_redirected_to login_path
		@installation2 = Installation.first
		assert_match @installation2.name, "GIMP"
	end
	
	test "should not edit added_by for not admin user" do		
		log_in_as(@user_notadmin)
		@installation = Installation.first
		assert_equal @installation.user_id, 1
		assert_no_difference 'Installation.count' do
			patch :update, id: @installation, installation: {user_id: @user_admin.id}
		end
		assert_redirected_to root_path
		@installation2 = Installation.first
		assert_equal @installation2.user_id, 1
	end
	
	test "should not edit added_by for not logedin" do		
		@installation = Installation.first
		assert_equal @installation.user_id, 1
		assert_no_difference 'Installation.count' do
			patch :update, id: @installation, installation: {user_id: @user_admin.id}
		end
		assert_redirected_to login_path
		@installation2 = Installation.first
		assert_equal @installation2.user_id, 1
	end
	
end
