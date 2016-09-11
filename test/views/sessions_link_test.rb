require 'test_helper'

class SessionsInterfaceTest < ActionDispatch::IntegrationTest
	#assert_match "#{Line.count} lines", response.body
	def setup
		@user_active      = users(:michael)
		@user_notadmin    = users(:archer)
		@user             = users(:lana)		
	end
	
	# Log-in
	################################################
	
	test "log-in page, before" do
		get login_path
		assert_template 'sessions/new'
		assert_select "title", full_title("Log in")		
		assert_select "a[href=?]", root_path, count: 1
		assert_select "a[href=?]", help_path, count: 1
		assert_select "a[href=?]", about_path, count: 1
		assert_select "a[href=?]", contact_path, count: 1
		assert_select "a[href=?]", signup_path, count: 2
		assert_select "a[href=?]", login_path, count: 0
		assert_select "a[href=?]", users_path, count: 0		
		assert_select "a[href=?]", edit_user_path(@user), count: 0		
		assert_select "a[href=?]", logout_path, count: 0		
		assert_select "a[href=?]", lines_path, count: 0
		assert_select "a[href=?]", installations_path, count: 0		
		assert_select "a[href=?]", operating_systems_path, count: 0		
		assert_select "a[href=?]", createfile_path, count: 1
		assert_select "a[href=?]", password_resets_new_path, count: 1
		assert_select "input[id=session_remember_me]", count: 1
	end
	
	test "log-in page, after" do
		log_in_as(@user_active)
		assert_redirected_to root_path
		follow_redirect!
		assert_select "a[href=?]", root_path, count: 1
		assert_select "a[href=?]", help_path, count: 1
		assert_select "a[href=?]", about_path, count: 1
		assert_select "a[href=?]", contact_path, count: 1
		assert_select "a[href=?]", signup_path, count: 0
		assert_select "a[href=?]", login_path, count: 0
		assert_select "a[href=?]", users_path, count: 1		
		assert_select "a[href=?]", edit_user_path(@user_active), count: 1
		assert_select "a[href=?]", logout_path, count: 1		
		assert_select "a[href=?]", lines_path, count: 1
		assert_select "a[href=?]", installations_path, count: 1		
		assert_select "a[href=?]", operating_systems_path, count: 1		
		assert_select "a[href=?]", createfile_path, count: 1
		assert_select "a[href=?]", password_resets_new_path, count: 0
		assert_select "input[id=session_remember_me]", count: 0
	end
	
end