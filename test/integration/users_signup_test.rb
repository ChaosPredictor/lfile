require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
	#def setup
	#	@user = users(:michael)
	#end
	
	test "invalid signup information" do
		get signup_path
		assert_no_difference 'User.count' do
			post users_path, user: { name: "", email: "user@invalid", password: "foo", password_confirmation: "bar" }
		end
		assert_template 'users/new'
		#assert_select 'div#<CSS id for error explanation>'
		#assert_select 'div.<CSS class for field with error>'
		#assert_select 'div#error_explanation', "The form contains 4 errors.
		#
		#
		#		Name can't be blank\n				Email is invalid\n				Password confirmation doesn't match Password\n				Password is too short (minimum is 6 characters)"
		assert_select 'div#error_explanation'
		assert_select 'div.alert-danger', "The form contains 4 errors."
		assert_select 'div.alert'	
		assert_select 'div#error_explanation ul li', "Name can't be blank"
		assert_select 'div#error_explanation ul li', "Email is invalid"
		assert_select 'div#error_explanation ul li', "Password is too short (minimum is 6 characters)"			
		assert_select 'div#error_explanation ul li', "Password confirmation doesn't match Password"
	end
	
	test "invalid signup name information" do
		get signup_path
		assert_no_difference 'User.count' do
			post users_path, user: { name: "", email: "user@invalid.com", password: "foobar", password_confirmation: "foobar" }
		end
		assert_template 'users/new'
		assert_select 'div#error_explanation'
		assert_select 'div.alert-danger', "The form contains 1 error."
		assert_select 'div.alert'	
		assert_select 'div#error_explanation ul li', "Name can't be blank"		
	end
	
	test "invalid signup email information" do
		get signup_path
		assert_no_difference 'User.count' do
			post users_path, user: { name: "Dima", email: "user@invalid", password: "foobar", password_confirmation: "foobar" }
		end
		assert_template 'users/new'
		assert_select 'div#error_explanation'
		assert_select 'div.alert-danger', "The form contains 1 error."
		assert_select 'div.alert'	
		assert_select 'div#error_explanation ul li', "Email is invalid"		
	end
	
	test "invalid signup password information" do
		get signup_path
		assert_no_difference 'User.count' do
			post users_path, user: { name: "Dima", email: "user@invalid.com", password: "foo", password_confirmation: "foo" }
		end
		assert_template 'users/new'
		assert_select 'div#error_explanation'
		assert_select 'div.alert-danger', "The form contains 1 error."
		assert_select 'div.alert'	
		assert_select 'div#error_explanation ul li', "Password is too short (minimum is 6 characters)"		
	end
	
	test "invalid signup password confirmation information" do
		get signup_path
		assert_no_difference 'User.count' do
			post users_path, user: { name: "Dima", email: "user@invalid.com", password: "foobar1", password_confirmation: "foobar2" }
		end
		assert_template 'users/new'
		assert_select 'div#error_explanation'
		assert_select 'div.alert-danger', "The form contains 1 error."
		assert_select 'div.alert'	
		assert_select 'div#error_explanation ul li', "Password confirmation doesn't match Password"				
	end
	
	test "invalid signup email already been taken" do
		get signup_path
		assert_difference 'User.count' do
			post users_path, user: { name: "Dima1", email: "user@invalid.com", password: "foobar1", password_confirmation: "foobar1" }
		end
		assert_no_difference 'User.count' do
			post users_path, user: { name: "Dima2", email: "user@invalid.com", password: "foobar2", password_confirmation: "foobar2" }
		end
		assert_template 'users/new'
		assert_select 'div#error_explanation'
		assert_select 'div.alert-danger', "The form contains 1 error."
		assert_select 'div.alert'	
		assert_select 'div#error_explanation ul li', "Email has already been taken"				
	end
	
	test "valid signup information" do
		get signup_path
		assert_difference 'User.count', 1 do
			post users_path, user: { name: "Dima", email: "user@invalid.com", password: "foobar", password_confirmation: "foobar" }
		end
		assert_equal flash[:success], 'Welcome to the Sample App!' 
		assert_template @user
		assert_not flash[:error]
		#assert_select 'div.alert'
	end
		
end
