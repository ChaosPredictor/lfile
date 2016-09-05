require 'test_helper'

class UsersControllerTest < ActionController::TestCase
	def setup
		@user         =	users(:michael)
		@other_user   = users(:archer)
		@other_user2  = users(:lana)		
	end
	
	#User Not logged in
	####################################################
	
	test "should not get index for not logged in user" do
    get :index
		assert_not flash.empty?
		assert_equal "Please log in.", flash[:danger]
  end
	
	test "should not get show for not logged in user" do
    get :show, id: @user
		assert_not flash.empty?
		assert_equal  "Please log in.", flash[:danger]
  end
	
	test "should get new for not logged in user" do
    get :new
		assert_equal 200, response.status
    assert_response :success
		assert_select 'h1', text: "Sign up", count: 1
  end	
	
	test "should get create for not logged in user" do
    get :create, id: @user, user: { name: "My Name", email: "this@my.email", password: "password", password_confirmation: "password"}
		assert_equal 302, response.status
    assert_response :redirect
		assert_not flash.empty?
		assert_equal  "Please check your email to activate your account.", flash[:success]
	end

	
	
	test "should redirect edit when not logged in" do
		get :edit, id: @user
		assert_not flash.empty?
		assert_redirected_to login_url
		assert_equal flash[:danger], "Please log in."
	end
	
	test "should redirect update when not logged in" do
		patch :update, id: @user, user: { name: @user.name, email: @user.email }
		assert_not flash.empty?
		assert_redirected_to login_url
		assert_equal flash[:danger], "Please log in."
	end
	
	test "should redirect edit when logged in as wrong user" do
		log_in_as(@other_user)
		get :edit, id: @user
		assert flash.empty?
		assert_redirected_to root_url
	end

	test "should redirect update when logged in as wrong user" do
		log_in_as(@other_user)
		patch :update, id: @user, user: { name: @user.name, email: @user.email }
		assert flash.empty?
		assert_redirected_to root_url
	end
	
	test "should not allow the admin attribute to be edited via the web" do
		log_in_as(@other_user)
		assert_not @other_user.admin?
		patch :update, id: @other_user, user: { password: "password", 
																						password_confirmation: "password",
																						admin: true }
		assert_not @other_user.admin?
	end
	
	test "should redirect index when not logged in" do
		get :index
		assert_redirected_to login_url
	end
	
	
	test "should redirect destroy when not logged in" do
		assert_no_difference 'User.count' do
			delete :destroy, id: @user
		end
		assert_redirected_to login_url
	end
	
	test "should redirect destroy when logged in as a non-admin" do
		log_in_as(@other_user)
		assert_no_difference 'User.count' do
			delete :destroy, id: @user
		end
		assert_redirected_to root_url
	end
	
	test "should redirect following when not logged in" do
		get :following, id: @user
		assert_redirected_to login_url
	end
	
	test "should redirect followers when not logged in" do
		get :followers, id: @user
		assert_redirected_to login_url
	end
	
end
