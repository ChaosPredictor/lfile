require 'test_helper'

class SessionLoginTest < ActionDispatch::IntegrationTest
	
	test "invalid login password information" do
		@user = {user:{name: "Dima1", email: "user1@invalid.com", password: "foobar1", password_confirmation: "foobar1"}}
		get signup_path
		assert_difference 'User.count' do
			post users_path, @user
		end
		get login_path
		post login_path, session: { email: @user[:user][:email], password: "fooobar2" }
		
		assert_template 'new'
		assert_equal flash[:danger], 'Invalid email/password combination'
		assert_select 'div.alert'	
		assert_select 'div.alert-danger', "Invalid email/password combination"
		#assert_select "a[href=?]", login_path, count: 1
		#assert_select "a[href=?]", logout_path, count: 0
		#assert_select "a[href=?]", user_path(1), count: 0
	end
			
	test "login with valid information" do
		@user = {user:{name: "Dima1", email: "user1@invalid.com", password: "foobar1", password_confirmation: "foobar1"}}
		get signup_path
		assert_difference 'User.count' do
			post users_path, @user
		end
		get login_path
		post login_path, session: { email: @user[:user][:email], password: @user[:user][:password] }

		assert_equal flash[:success], 'Welcome Home!'
		assert_redirected_to user_path(session[:user_id])
		follow_redirect!
		assert_template 'users/show'
		assert_select "a[href=?]", login_path, count: 0
		assert_select "a[href=?]", logout_path, count: 1
		assert_select "a[href=?]", user_path(session[:user_id]), count: 1
		assert is_logged_in?
		
		delete logout_path
		assert_not is_logged_in?
		assert_redirected_to root_url
		follow_redirect!
		assert_select "a[href=?]", login_path
		assert_select "a[href=?]", logout_path, count: 0
		assert_select "a[href=?]", user_path(1), count: 0
		#TODO check that there is not link to any user
	end
	
	test "login with valid information followed by logout" do
		@user = {user:{name: "Dima1", email: "user1@invalid.com", password: "foobar1", password_confirmation: "foobar1"}}
		get signup_path
		assert_difference 'User.count' do
			post users_path, @user
		end
		get login_path
		post login_path, session: { email: @user[:user][:email], password: @user[:user][:password] }
		assert is_logged_in?
		assert_redirected_to user_path(session[:user_id])
		follow_redirect!
		assert_template 'users/show'
		assert_select "a[href=?]", login_path, count: 0
		assert_select "a[href=?]", logout_path
		assert_select "a[href=?]", user_path(session[:user_id])
		delete logout_path
		assert_not is_logged_in?
		assert_redirected_to root_url
		# Simulate a user clicking logout in a second window.
		delete logout_path
		follow_redirect!
		assert_select "a[href=?]", login_path
		assert_select "a[href=?]", logout_path,count: 0
		assert_select "a[href=?]", user_path(1), count: 0
	end
	
	test "authenticated? should return false for a user with nil digest" do
		#@user = {user:{name: "Dima1", email: "user1@invalid.com", password: "foobar1", password_confirmation: "foobar1"}}
		@user = User.new(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
		#get signup_path
		#assert_difference 'User.count' do
		#	post users_path, @user
		#end
		assert_not @user.authenticated?('')
	end
	
end
