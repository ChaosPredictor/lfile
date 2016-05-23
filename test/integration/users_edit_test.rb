require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  
	def setup
		@user = users(:michael)
		@user2 = users(:dmitry)
	end
	
	test "unsuccessful edit all 4 reason" do
		get edit_user_path(@user)
		assert_template 'users/edit'
		patch user_path(@user), user: {name: "", email: "foo@invalid", password: "foo", password_confirmation: "bar"}
		assert_template 'users/edit'
		assert_select 'div#error_explanation'
		assert_select 'div.alert-danger', "The form contains 4 errors."
		assert_select 'div.alert'	
		assert_select 'div#error_explanation ul li', "Name can't be blank"
		assert_select 'div#error_explanation ul li', "Email is invalid"
		assert_select 'div#error_explanation ul li', "Password is too short (minimum is 6 characters)"			
		assert_select 'div#error_explanation ul li', "Password confirmation doesn't match Password"
	end
	
	test "unsuccessful edit black name" do
		get edit_user_path(@user)
		assert_template 'users/edit'
		patch user_path(@user), user: {name: "", email: "foo@invalid.com", password: "foobar", password_confirmation: "foobar"}
		assert_template 'users/edit'
		assert_select 'div#error_explanation'
		assert_select 'div.alert-danger', "The form contains 1 error."
		assert_select 'div.alert'	
		assert_select 'div#error_explanation ul li', "Name can't be blank"
	end
	
	test "unsuccessful edit invalid email" do
		get edit_user_path(@user)
		assert_template 'users/edit'
		patch user_path(@user), user: {name: "dima", email: "foo@invalid", password: "foobar", password_confirmation: "foobar"}
		assert_template 'users/edit'
		assert_select 'div#error_explanation'
		assert_select 'div.alert-danger', "The form contains 1 error."
		assert_select 'div.alert'	
		assert_select 'div#error_explanation ul li', "Email is invalid"
	end
	
	test "unsuccessful edit short password" do
		get edit_user_path(@user)
		assert_template 'users/edit'
		patch user_path(@user), user: {name: "dima", email: "foo@invalid.com", password: "foo", password_confirmation: "foo"}
		assert_template 'users/edit'
		assert_select 'div#error_explanation'
		assert_select 'div.alert-danger', "The form contains 1 error."
		assert_select 'div.alert'	
		assert_select 'div#error_explanation ul li', "Password is too short (minimum is 6 characters)"
	end
	
	test "unsuccessful edit password confirmation wrong" do
		get edit_user_path(@user)
		assert_template 'users/edit'
		patch user_path(@user), user: {name: "dima", email: "foo@invalid.com", password: "foobar1", password_confirmation: "foobar2"}
		assert_template 'users/edit'
		assert_select 'div#error_explanation'
		assert_select 'div.alert-danger', "The form contains 1 error."
		assert_select 'div.alert'	
		assert_select 'div#error_explanation ul li', "Password confirmation doesn't match Password"
	end
	
	test "unsuccessful edit email already been taken" do
		get signup_path
		assert_difference 'User.count' do
			post users_path, user: { name: "Dima1", email: "user@invalid.com", password: "foobar1", password_confirmation: "foobar1" }
		end		
		get edit_user_path(@user)
		assert_template 'users/edit'
		patch user_path(@user), user: {name: "Dima2", email: "user@invalid.com", password: "foobar1", password_confirmation: "foobar1"}
		assert_template 'users/edit'
		assert_select 'div#error_explanation'
		assert_select 'div.alert-danger', "The form contains 1 error."
		assert_select 'div.alert'	
		assert_select 'div#error_explanation ul li', "Email has already been taken"
	end
	
	#test "successful edit" do
	#	get edit_user_path(@user)
	#	assert_template 'users/edit'
	#	patch user_path(@user), user: {name: "Dima", email: "foo@invalid.com", password: "foobar", password_confirmation: "foobar"}
	#	assert_equal flash[:success], 'Nice Chose, Welcome back!' 
	#	#assert_redirected_to user_path(@user)
	#	follow_redirect!
	#	assert_template 'users/show'
	#	assert_not flash[:error]
	#	assert_select "a[href=?]", login_path, count: 0
	#	assert_select "a[href=?]", logout_path, count: 1
	#	assert_select "a[href=?]", user_path(session[:user_id]), count: 1
	#	assert is_logged_in?
	#end
	
	test "successful edit2" do
		get edit_user_path(@user)
		assert_template 'users/edit'
		name = "Foo Bar"
		email = "foo@bar.com"
		patch user_path(@user), user: { name: name, email: email, password: "", password_confirmation: "" }
		assert_not flash.empty?
		assert_equal flash[:success], 'Nice Chose, Welcome back!'
		assert_redirected_to @user
		@user.reload
		assert_equal name, @user.name
		assert_equal email, @user.email
	end
end