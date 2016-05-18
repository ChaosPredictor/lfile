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
	end
	
end
