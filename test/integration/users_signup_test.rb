require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
	
	def setup
		ActionMailer::Base.deliveries.clear
	end
	
	test "invalid signup information" do
		get signup_path
		assert_no_difference 'User.count' do
			post users_path, params: {'user' => { 'name' => "", 'email' => "user@invalid", 'password' => "foo", 'password_confirmation' => "bar" }}
		end
		assert_template 'users/new'
		assert_select 'div#error_explanation'
		assert_select 'div.alert-danger', "The form contains 4 errors."
		assert_select 'div.alert'	
		assert_select 'div#error_explanation ul li', "Name can't be blank"
		assert_select 'div#error_explanation ul li', "Email is invalid"
		assert_select 'div#error_explanation ul li', "Password is too short (minimum is 6 characters)"			
		assert_select 'div#error_explanation ul li', "Password confirmation doesn't match Password"
		assert_select "a[href=?]", login_path, count: 1
		assert_select "a[href=?]", logout_path, count: 0
		assert_select "a[href=?]", user_path(1), count: 0
		assert_not is_logged_in?
	end
	
	test "invalid signup name information" do
		get signup_path
		assert_no_difference 'User.count' do
			post users_path, params: {'user' => { 'name' => "", 'email' => "user@invalid.com", 'password' => "foobar", 'password_confirmation' => "foobar" }}
		end
		assert_template 'users/new'
		assert_select 'div#error_explanation'
		assert_select 'div.alert-danger', "The form contains 1 error."
		assert_select 'div.alert'	
		assert_select 'div#error_explanation ul li', "Name can't be blank"		
		assert_not is_logged_in?
	end
	
	test "invalid signup email information" do
		get signup_path
		assert_no_difference 'User.count' do
			post users_path, params: {'user' => { 'name' => "Dima", 'email' => "user@invalid", 'password' => "foobar", 'password_confirmation' => "foobar" }}
		end
		assert_template 'users/new'
		assert_select 'div#error_explanation'
		assert_select 'div.alert-danger', "The form contains 1 error."
		assert_select 'div.alert'	
		assert_select 'div#error_explanation ul li', "Email is invalid"		
		assert_not is_logged_in?
	end
	
	test "invalid signup password information" do
		get signup_path
		assert_no_difference 'User.count' do
			post users_path, params: {'user' => { 'name' => "Dima", 'email' => "user@invalid.com", 'password' => "foo", 'password_confirmation' => "foo" }}
		end
		assert_template 'users/new'
		assert_select 'div#error_explanation'
		assert_select 'div.alert-danger', "The form contains 1 error."
		assert_select 'div.alert'	
		assert_select 'div#error_explanation ul li', "Password is too short (minimum is 6 characters)"		
		assert_not is_logged_in?
	end
	
	test "invalid signup password confirmation information" do
		get signup_path
		assert_no_difference 'User.count' do
			post users_path, params: {'user' => { 'name' => "Dima", 'email' => "user@invalid.com", 'password' => "foobar1", 'password_confirmation' => "foobar2" }}
		end
		assert_template 'users/new'
		assert_select 'div#error_explanation'
		assert_select 'div.alert-danger', "The form contains 1 error."
		assert_select 'div.alert'	
		assert_select 'div#error_explanation ul li', "Password confirmation doesn't match Password"
		assert_not is_logged_in?
	end
	
	test "invalid signup email already been taken" do
		get signup_path
		assert_difference 'User.count' do
			post users_path, params: {'user' => { 'name' => "Dima1", 'email' => "user@invalid.com", 'password' => "foobar1", 'password_confirmation' => "foobar1" }}
		end
		assert_no_difference 'User.count' do
			post users_path, params: {'user' => { 'name' => "Dima2", 'email' => "user@invalid.com", 'password' => "foobar2", 'password_confirmation' => "foobar2" }}
		end
		assert_template 'users/new'
		assert_select 'div#error_explanation'
		assert_select 'div.alert-danger', "The form contains 1 error."
		assert_select 'div.alert'	
		assert_select 'div#error_explanation ul li', "Email has already been taken"
	end
	
	test "valid signup informationwith account activation" do
		get signup_path
		assert_difference 'User.count', 1 do
			post users_path, params: {'user' => { 'name' => "Example User", 'email' => "user@example.com", 'password' => "password", 'password_confirmation' => "password" }}
		end
		assert_equal 1, ActionMailer::Base.deliveries.size
		user = assigns(:user)
		assert_not user.activated?
		# Try to log in before activation.
		log_in_as(user)
		assert_not is_logged_in?
		# Invalid activation token
		get edit_account_activation_path("invalid token")
		assert_not is_logged_in?
		# Valid token, wrong email
		get edit_account_activation_path(user.activation_token, email: 'wrong')
		assert_not is_logged_in?
		# Valid activation token
		get edit_account_activation_path(user.activation_token, email: user.email)
		assert user.reload.activated?
		follow_redirect!
		assert_template 'users/show'
		assert is_logged_in?
	end
	
		
end
