require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
	
	def setup
		@user = users(:michael)
		@user2 = users(:dmitry)
		@user_notAdmin = users(:archer)
		@user_admin = users(:michael)
		ActionMailer::Base.deliveries.clear
	end
	
	#Root - Home
	#########################################3
	
	test "links home page without logged in user" do
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
		log_in_as(@user_notAdmin)
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
		assert_select "a[href=?]", edit_user_path(@user_notAdmin), count: 1				
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
	
	
	#Root - Help
	#########################################3
	
	test "links help page without logged in user" do
		get help_path
		assert_template 'static_pages/help'
		assert_select "title", full_title("Help")			
		assert_select "a[href=?]", root_path, count: 1
		assert_select "a[href=?]", help_path, count: 0
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
	
	test "links help page with logged in user" do
		log_in_as(@user_notAdmin)
		get help_path
		assert_template 'static_pages/help'
		assert_select "title", full_title("Help")	
		assert_select "a[href=?]", root_path, count: 1
		assert_select "a[href=?]", help_path, count: 0
		assert_select "a[href=?]", about_path, count: 1
		assert_select "a[href=?]", contact_path, count: 1
		assert_select "a[href=?]", signup_path, count: 0
		assert_select "a[href=?]", login_path, count: 0
		assert_select "a[href=?]", users_path, count: 0
		assert_select "a[href=?]", edit_user_path(@user_notAdmin), count: 1		
		assert_select "a[href=?]", logout_path, count: 1
		assert_select "a[href=?]", lines_path, count: 1
		assert_select "a[href=?]", installations_path, count: 1
		assert_select "a[href=?]", operating_systems_path, count: 1
		assert_select "a[href=?]", createfile_path, count: 1
	end	
	
	test "links help page with admin logged in user" do
		log_in_as(@user_admin)
		get help_path
		assert_template 'static_pages/help'
		assert_select "title", full_title("Help")	
		assert_select "a[href=?]", root_path, count: 1
		assert_select "a[href=?]", help_path, count: 0
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
	
	
		#Root - About
	#########################################3
	
	test "links about page without logged in user" do
		get about_path
		assert_template 'static_pages/about'
		assert_select "title", full_title("About")			
		assert_select "a[href=?]", root_path, count: 1
		assert_select "a[href=?]", help_path, count: 1
		assert_select "a[href=?]", about_path, count: 0
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
	
	test "links about page with logged in user" do
		log_in_as(@user_notAdmin)
		get about_path
		assert_template 'static_pages/about'
		assert_select "title", full_title("About")	
		assert_select "a[href=?]", root_path, count: 1
		assert_select "a[href=?]", help_path, count: 1
		assert_select "a[href=?]", about_path, count: 0
		assert_select "a[href=?]", contact_path, count: 1
		assert_select "a[href=?]", signup_path, count: 0
		assert_select "a[href=?]", login_path, count: 0
		assert_select "a[href=?]", users_path, count: 0
		assert_select "a[href=?]", edit_user_path(@user_notAdmin), count: 1		
		assert_select "a[href=?]", logout_path, count: 1
		assert_select "a[href=?]", lines_path, count: 1
		assert_select "a[href=?]", installations_path, count: 1
		assert_select "a[href=?]", operating_systems_path, count: 1
		assert_select "a[href=?]", createfile_path, count: 1
	end	
	
	test "links about page with admin logged in user" do
		log_in_as(@user_admin)
		get about_path
		assert_template 'static_pages/about'
		assert_select "title", full_title("About")	
		assert_select "a[href=?]", root_path, count: 1
		assert_select "a[href=?]", help_path, count: 1
		assert_select "a[href=?]", about_path, count: 0
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
	
	
	#Root - Contact
	#########################################3
	
	test "links contact page without logged in user" do
		get contact_path
		assert_template 'static_pages/contact'
		assert_select "title", full_title("Contact")			
		assert_select "a[href=?]", root_path, count: 1
		assert_select "a[href=?]", help_path, count: 1
		assert_select "a[href=?]", about_path, count: 1
		assert_select "a[href=?]", contact_path, count: 0
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
	
	test "links contact page with logged in user" do
		log_in_as(@user_notAdmin)
		get contact_path
		assert_template 'static_pages/contact'
		assert_select "title", full_title("Contact")	
		assert_select "a[href=?]", root_path, count: 1
		assert_select "a[href=?]", help_path, count: 1
		assert_select "a[href=?]", about_path, count: 1
		assert_select "a[href=?]", contact_path, count: 0
		assert_select "a[href=?]", signup_path, count: 0
		assert_select "a[href=?]", login_path, count: 0
		assert_select "a[href=?]", users_path, count: 0
		assert_select "a[href=?]", edit_user_path(@user_notAdmin), count: 1		
		assert_select "a[href=?]", logout_path, count: 1
		assert_select "a[href=?]", lines_path, count: 1
		assert_select "a[href=?]", installations_path, count: 1
		assert_select "a[href=?]", operating_systems_path, count: 1
		assert_select "a[href=?]", createfile_path, count: 1
	end	
	
	test "links contact page with admin logged in user" do
		log_in_as(@user_admin)
		get contact_path
		assert_template 'static_pages/contact'
		assert_select "title", full_title("Contact")	
		assert_select "a[href=?]", root_path, count: 1
		assert_select "a[href=?]", help_path, count: 1
		assert_select "a[href=?]", about_path, count: 1
		assert_select "a[href=?]", contact_path, count: 0
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
	
	
	
	
	
	
	
	
	#Root - Home
	##########################3
	
	
	test "views home page without logged in user" do
		get root_path
		assert_template 'static_pages/home'
		assert_select "title", full_title("Home")	
	end
		
	test "layout links login page" do
		get login_path		
		assert_select "title", full_title("Log in")
		assert_select "a[href=?]", root_path, count: 1
		assert_select "a[href=?]", help_path
		assert_select "a[href=?]", about_path
		assert_select "a[href=?]", contact_path
		assert_select "a[href=?]", login_path
		assert_select "a[href=?]", new_password_reset_path
	end
	
	test "layout links signup page" do
		get signup_path		
		assert_select "title", full_title("Sign up")
		assert_select "a[href=?]", root_path, count: 1
		assert_select "a[href=?]", help_path
		assert_select "a[href=?]", about_path
		assert_select "a[href=?]", contact_path
		assert_select "a[href=?]", login_path		
	end
		
	test "layout page" do
		get root_path
		assert_select "ul.nav"
		assert_select "ul.navbar-nav"
		assert_select "ul.navbar-right"
	end
	
	test "help page" do
		get help_path
		assert_select "ul.nav"
		assert_select "ul.navbar-nav"
		assert_select "ul.navbar-right"
	end
	
	test "About page" do
		get about_path
		assert_select "ul.nav"
		assert_select "ul.navbar-nav"
		assert_select "ul.navbar-right"
	end
	
	test "Contact page" do
		get contact_path
		assert_select "ul.nav"
		assert_select "ul.navbar-nav"
		assert_select "ul.navbar-right"
	end
	
	test "Login page" do
		get login_path
		assert_select "ul.nav"
		assert_select "ul.navbar-nav"
		assert_select "ul.navbar-right"
	end
	
	test "Signup page" do
		get signup_path
		assert_select "ul.nav"
		assert_select "ul.navbar-nav"
		assert_select "ul.navbar-right"
	end
	
	
	#Should move from here to other file
#	test "logged-in user" do
#		get signup_path
#		assert_difference 'User.count', 1 do
#			post users_path, user: { name: "Example User", email: "user@example.com", password: "password", password_confirmation: "password" }
#		end
#		assert_equal 1, ActionMailer::Base.deliveries.size
#		user = assigns(:user)
#		get edit_account_activation_path(user.activation_token, email: user.email)
#		assert user.reload.activated?
#		follow_redirect!
#		assert_template 'users/show'
#		assert is_logged_in?
#		assert_equal flash[:success], "Account activated!"
#		#get root_path
#		assert_select "a[href=?]", root_path, count: 1
#		assert_select "a[href=?]", installations_path, count: 1		
#		assert_select "a[href=?]", lines_path, count: 1		
#		assert_select "a[href=?]", help_path
#		assert_select "a[href=?]", about_path
#		assert_select "a[href=?]", contact_path
#		assert_select "a[href=?]", signup_path, count: 0
#		assert_select "a[href=?]", login_path, count: 0
#		assert_select "a[href=?]", user_path(user), count: 1		
#		assert_select "a[href=?]", edit_user_path(user), count: 1		
#		assert_select "a[href=?]", logout_path, count: 1
#	end
	
end
