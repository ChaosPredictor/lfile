require 'test_helper'

class SessionLoginTest < ActionDispatch::IntegrationTest
	
	test "invalid login password information" do
		get signup_path
		assert_difference 'User.count' do
			post users_path, user: { name: "Dima", email: "user@invalid.com", password: "foobar1", password_confirmation: "foobar1" }
		end
		get login_path
		post login_path, session: {email: "user@invalid.com", password: "foobar2" }
		
		assert_template 'new'
		assert_select 'div.alert'	
		assert_select 'div.alert-danger', "Invalid email/password combination"				
	end
	
	test "valid login" do
		get signup_path
		assert_difference 'User.count' do
			post users_path, user: { name: "Dima", email: "user@invalid.com", password: "foobar1", password_confirmation: "foobar1" }
		end
		get login_path
		post login_path, session: {email: "user@invalid.com", password: "foobar1" }
		
		assert_template @user
	end
end
