require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
	test "invalid signup name information" do
		get signup_path
		assert_no_difference 'User.count' do
			post users_path, user: { name: "", email: "user@invalid.com", password: "foobar", password_confirmation: "foobar" }
		end
		assert_template 'users/new'
	end
	
	test "invalid signup email information" do
		get signup_path
		assert_no_difference 'User.count' do
			post users_path, user: { name: "Dima", email: "user@invalid", password: "foobar", password_confirmation: "foobar" }
		end
		assert_template 'users/new'
	end
	
	test "invalid signup password information" do
		get signup_path
		assert_no_difference 'User.count' do
			post users_path, user: { name: "Dima", email: "user@invalid.com", password: "foo", password_confirmation: "foo" }
		end
		assert_template 'users/new'
	end
	
	test "invalid signup password confirmation information" do
		get signup_path
		assert_no_difference 'User.count' do
			post users_path, user: { name: "Dima", email: "user@invalid.com", password: "foobar1", password_confirmation: "foobar2" }
		end
		assert_template 'users/new'
	end
	
	test "valid signup information" do
		get signup_path
		assert_difference 'User.count', 1 do
			post users_path, user: { name: "Dima", email: "user@invalid.com", password: "foobar", password_confirmation: "foobar" }
		end
    assert_select flash[:success], "Welcome to the Sample App!"
		assert_template @user
		#assert_template 'users/show'		
	end	
end
