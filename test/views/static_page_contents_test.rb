require 'test_helper'

class StaticPageContentsInterfaceTest < ActionDispatch::IntegrationTest
	
	def setup
		@user_admin       = users(:michael)
		@user_notadmin    = users(:archer)
		@user             = users(:lana)		

	end
	
	
	#Root - Home
	#########################################3
	
	test "links home page, not logged in user" do
		get root_path
		assert_template 'static_pages/home'
		assert_select "title", full_title("Home")		
		assert_select "a.name-toggle", text: @user.name, count: 0		
		assert_select "a.admin-flag", text: "Admin!!!", count: 0
		assert_select "a#logo", text: "linux apps installer", count: 1		
	end
	
	test "links home page with logged in user" do
		log_in_as(@user_notadmin)
		get root_path
		assert_template 'static_pages/home'
		assert_select "title", full_title("Home")	
		assert_select "a.name-toggle", text: @user_notadmin.name, count: 1		
		assert_select "a.admin-flag", text: "Admin!!!", count: 0
		assert_select "a#logo", text: "linux apps installer", count: 1
	end	
	
	test "links home page with admin logged in user" do
		log_in_as(@user_admin)
		get root_path
		assert_template 'static_pages/home'
		assert_select "title", full_title("Home")	
		assert_select "a.name-toggle", text: @user_admin.name, count: 1
		assert_select "a.admin-flag", text: "Admin!!!", count: 1
		assert_select "a#logo", text: "linux apps installer", count: 1
	end
	
end