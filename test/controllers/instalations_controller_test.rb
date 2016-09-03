require 'test_helper'

class InstalationsControllerTest < ActionController::TestCase
	def setup
		@instalation      = instalations(:gimp)
		@user_admin       = users(:michael)
		@user_notadmin    = users(:archer)		
	end
	
  test "should create new only if login" do
		#get :new
		assert_no_difference 'Instalation.count' do
			post :create, instalation: { name: "Lorem", version: "1.1", os: "new", source_link: "google.com" }
		end
		assert_response :redirect
		assert_redirected_to login_url
		log_in_as(@user_admin)
		#get :new
		assert_difference 'Instalation.count' do
			post :create, instalation: { name: "Lorem", version: "1.1", os: "new", source_link: "google.com" }
		end
		assert_equal flash[:success], "New Instalation Saved!!!"
		assert_response :redirect
		assert_redirected_to instalations_path
		@instalation2 = Instalation.last
		assert_match @instalation2.name, "Lorem"
		assert_match @instalation2.version, "1.1"
		assert_match @instalation2.os, "new"
		assert_match @instalation2.source_link, "google.com"
		assert_equal @instalation2.user_id, @user_admin.id
  end
	
	test "should create when admin" do
		log_in_as(@user_admin)
		assert_difference 'Instalation.count', 1 do
			post :create, instalation: { name: "Lorem", version: "1.1", os: "new", source_link: "google.com" }
		end
		assert_redirected_to instalations_path
		@instalation2 = Instalation.last
		assert_match @instalation2.name, "Lorem"
		assert_match @instalation2.version, "1.1"
		assert_match @instalation2.os, "new"
		assert_match @instalation2.source_link, "google.com"
		assert_equal @instalation2.user_id, @user_admin.id
	end
	
	test "should create when logged in" do
		log_in_as(@user_notadmin)
		assert_difference 'Instalation.count', 1 do
			post :create, instalation: { name: "Lorem", version: "1.1", os: "new", source_link: "google.com" }
		end
		assert_redirected_to instalations_path
		@instalation2 = Instalation.last
		assert_match @instalation2.name, "Lorem"
		assert_match @instalation2.version, "1.1"
		assert_match @instalation2.os, "new"
		assert_match @instalation2.source_link, "google.com"
		assert_equal @instalation2.user_id, @user_notadmin.id
	end
		
	test "should redirect create when not logged in" do
		assert_no_difference 'Instalation.count' do
			post :create, instalation: { name: "Lorem", version: "1.1", os: "new", source_link: "google.com", user_id: 1 }
		end
		assert_redirected_to login_url
	end
	
	test "should redirect destroy when not logged in" do
		assert_no_difference 'Instalation.count' do
			delete :destroy, id: @instalation
		end
		assert_redirected_to login_url
	end
	
	test "should redirect destroy for not admin user" do
		log_in_as(@user_notadmin)
		instalation = instalations(:firefox)
		assert_no_difference 'Instalation.count' do
			delete :destroy, id: instalation
		end
		assert_redirected_to root_url
	end
	
	test "should destroy for admin user" do		
		log_in_as(@user_admin)
		@instalation = instalations(:gimp)
		assert_difference 'Instalation.count', -1 do
			delete :destroy, id: @instalation
		end
		assert_redirected_to instalations_path
	end
	
	test "should edit for admin user" do		
		log_in_as(@user_admin)
		@instalation = Instalation.first
		assert_match @instalation.name, "GIMP"
		assert_match @instalation.version, "1.1"
		assert_match @instalation.os, "linux"
		assert_match @instalation.source_link, "gimp.com"
		assert_equal @instalation.user_id, 1		
		assert_no_difference 'Instalation.count' do
			patch :update, id: @instalation, instalation: {name: "PIMG",
																											version: "1.2",
																											os: "xos",
																											source_link: "pmig.com",
																											user_id: @user_admin.id}
		end
		assert_redirected_to instalations_path
		@instalation2 = Instalation.first
		assert_match @instalation2.name, "PIMG"
		assert_match @instalation2.version, "1.2"
		assert_match @instalation2.os, "xos"
		assert_match @instalation2.source_link, "pmig.com"
		assert_equal @instalation.user_id, 1
		assert_not_equal @instalation.user_id, @user_admin.id
	end
	
	
	test "should edit for admin user version only" do		
		log_in_as(@user_admin)
		@instalation = Instalation.first
		assert_match @instalation.name, "GIMP"
		assert_match @instalation.version, "1.1"
		assert_match @instalation.os, "linux"
		assert_match @instalation.source_link, "gimp.com"
		assert_no_difference 'Instalation.count' do
			patch :update, id: @instalation, instalation: {version: "1.2"}
		end
		assert_redirected_to instalations_path
		@instalation2 = Instalation.first
		assert_match @instalation2.name, "GIMP"
		assert_match @instalation2.version, "1.2"
		assert_match @instalation2.os, "linux"
		assert_match @instalation2.source_link, "gimp.com"
	end
	
	test "should edit for admin user os only" do		
		log_in_as(@user_admin)
		@instalation = Instalation.first
		assert_match @instalation.name, "GIMP"
		assert_match @instalation.version, "1.1"
		assert_match @instalation.os, "linux"
		assert_match @instalation.source_link, "gimp.com"
		assert_no_difference 'Instalation.count' do
			patch :update, id: @instalation, instalation: {os: "xos"}
		end
		assert_redirected_to instalations_path
		@instalation2 = Instalation.first
		assert_match @instalation2.name, "GIMP"
		assert_match @instalation2.version, "1.1"
		assert_match @instalation2.os, "xos"
		assert_match @instalation2.source_link, "gimp.com"
	end
	
	test "should edit for admin user source link only" do		
		log_in_as(@user_admin)
		@instalation = Instalation.first
		assert_match @instalation.name, "GIMP"
		assert_match @instalation.version, "1.1"
		assert_match @instalation.os, "linux"
		assert_match @instalation.source_link, "gimp.com"
		assert_no_difference 'Instalation.count' do
			patch :update, id: @instalation, instalation: {source_link: "pmig.com"}
		end
		assert_redirected_to instalations_path
		@instalation2 = Instalation.first
		assert_match @instalation2.name, "GIMP"
		assert_match @instalation2.version, "1.1"
		assert_match @instalation2.os, "linux"
		assert_match @instalation2.source_link, "pmig.com"
	end
	
	test "should edit for admin user without user change" do		
		log_in_as(@user_admin)
		@instalation = Instalation.first
		assert_equal @instalation.user_id, 1
		assert_no_difference 'Instalation.count' do
			patch :update, id: @instalation, instalation: {user_id: @user_admin.id}
		end
		assert_redirected_to instalations_path
		@instalation2 = Instalation.first
		assert_equal @instalation.user_id, 1
		assert_not_equal @instalation.user_id, @user_admin.id		
	end
	
	test "should not edit for not admin user" do		
		log_in_as(@user_notadmin)
		@instalation = Instalation.first
		assert_match @instalation.name, "GIMP"
		assert_no_difference 'Instalation.count' do
			patch :update, id: @instalation, instalation: {name: "PIMG"}
		end
		assert_redirected_to root_path
		@instalation2 = Instalation.first
		assert_match @instalation2.name, "GIMP"
	end
	
	test "should not edit for not logedin" do		
		@instalation = Instalation.first
		assert_match @instalation.name, "GIMP"
		assert_no_difference 'Instalation.count' do
			patch :update, id: @instalation, instalation: {name: "PIMG"}
		end
		assert_redirected_to login_path
		@instalation2 = Instalation.first
		assert_match @instalation2.name, "GIMP"
	end
	
	test "should not edit added_by for not admin user" do		
		log_in_as(@user_notadmin)
		@instalation = Instalation.first
		assert_equal @instalation.user_id, 1
		assert_no_difference 'Instalation.count' do
			patch :update, id: @instalation, instalation: {user_id: @user_admin.id}
		end
		assert_redirected_to root_path
		@instalation2 = Instalation.first
		assert_equal @instalation2.user_id, 1
	end
	
	test "should not edit added_by for not logedin" do		
		@instalation = Instalation.first
		assert_equal @instalation.user_id, 1
		assert_no_difference 'Instalation.count' do
			patch :update, id: @instalation, instalation: {user_id: @user_admin.id}
		end
		assert_redirected_to login_path
		@instalation2 = Instalation.first
		assert_equal @instalation2.user_id, 1
	end
	
end
