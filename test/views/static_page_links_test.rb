require 'test_helper'

class StaticPageLinksInterfaceTest < ActionDispatch::IntegrationTest
	
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
		assert_select "a[href=?]", root_path, count: 1
		assert_select "a[href=?]", help_path, count: 1
		assert_select "a[href=?]", about_path, count: 1
		assert_select "a[href=?]", contact_path, count: 1
		assert_select "a[href=?]", signup_path, count: 1
		assert_select "a[href=?]", login_path, count: 1
		assert_select "a[href=?]", users_path, count: 0		
		assert_select "a[href=?]", edit_user_path(@user), count: 0		
		assert_select "a[href=?]", logout_path, count: 0		
		assert_select "a[href=?]", lines_path, count: 0
		assert_select "a[href=?]", installations_path, count: 0		
		assert_select "a[href=?]", operating_systems_path, count: 0		
		assert_select "a[href=?]", createfile_path, count: 1
	end
	
	test "links home page with logged in user" do
		log_in_as(@user_notadmin)
		get root_path
		assert_template 'static_pages/home'
		assert_select "title", full_title("Home")	
		assert_select "a[href=?]", root_path, count: 1
		assert_select "a[href=?]", help_path, count: 1
		assert_select "a[href=?]", about_path, count: 1
		assert_select "a[href=?]", contact_path, count: 1
		assert_select "a[href=?]", signup_path, count: 0
		assert_select "a[href=?]", login_path, count: 0
		assert_select "a[href=?]", users_path, count: 0
		assert_select "a[href=?]", edit_user_path(@user_notadmin), count: 1				
		assert_select "a[href=?]", logout_path, count: 1
		assert_select "a[href=?]", lines_path, count: 1
		assert_select "a[href=?]", installations_path, count: 1	
		assert_select "a[href=?]", operating_systems_path, count: 1		
		assert_select "a[href=?]", createfile_path, count: 1
	end	
	
	test "links home page with admin logged in user" do
		log_in_as(@user_admin)
		get root_path
		assert_template 'static_pages/home'
		assert_select "title", full_title("Home")	
		assert_select "a[href=?]", root_path, count: 1
		assert_select "a[href=?]", help_path, count: 1
		assert_select "a[href=?]", about_path, count: 1
		assert_select "a[href=?]", contact_path, count: 1
		assert_select "a[href=?]", signup_path, count: 0
		assert_select "a[href=?]", login_path, count: 0
		assert_select "a[href=?]", users_path, count: 1
		assert_select "a[href=?]", edit_user_path(@user_admin), count: 1				
		assert_select "a[href=?]", logout_path, count: 1
		assert_select "a[href=?]", lines_path, count: 1
		assert_select "a[href=?]", installations_path, count: 1	
		assert_select "a[href=?]", operating_systems_path, count: 1
		assert_select "a[href=?]", createfile_path, count: 1
	end
	
end