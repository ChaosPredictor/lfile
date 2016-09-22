require 'test_helper'

class UsersControllerTest < ActionController::TestCase
	def setup
		@user_admin            = users(:michael)
		@user_notadmin         = users(:archer)
		@user                  = users(:lana)		
	end
	
	#User Not logged in
	####################################################
	
	test "should not get index for not logged in user" do
    get :index
		assert_not flash.empty?
		assert_equal "Please log in.", flash[:danger]
  end
	
	test "should not get show for not logged in user" do
    get :show, params: {'id' => @user}
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
    get :create, params: {'id' => @user, 'user' => { 'name' => "My Name", 'email' => "this@my.email", 'password' => "password", 'password_confirmation' => "password"}}
		assert_equal 302, response.status
    assert_response :redirect
		assert_not flash.empty?
		assert_equal  "Please check your email to activate your account.", flash[:success]
	end
	
	test "should redirect edit when not logged in" do
		get :edit, params: {'id' => @user}
    assert_response :redirect
		assert_redirected_to login_url
		assert_not flash.empty?
		assert_equal flash[:danger], "Please log in."
	end
	
	test "should redirect update when not logged in" do
		patch :update, params: {'id' => @user, 'user' => { 'name' => @user.name, 'email' => @user.email }}
    assert_response :redirect
		assert_redirected_to login_url
		assert_not flash.empty?		
		assert_equal flash[:danger], "Please log in."
	end
	
	test "should redirect destroy when not logged in" do
		assert_no_difference 'User.count' do
			delete :destroy, params: {'id' => @user}
		end
    assert_response :redirect
		assert_redirected_to login_url
		assert_equal flash[:danger], "Please log in."
	end
	
	#User logged in don't care (Correct) not admin
	####################################################	
	
	test "logged in, don't care, not admin should index" do
		log_in_as(@user_notadmin)
    get :index
		assert_equal 200, response.status
    assert_response :success
		assert_select 'h1', text: "All users", count: 1		
  end	
	
	test "logged in, don't care, not admin should not new" do
		log_in_as(@user_notadmin)
    get :new
		assert_equal 302, response.status
    assert_response :redirect
		assert_redirected_to root_path
  end	
	
	test "logged in, don't care, not admin should not create" do
		log_in_as(@user_notadmin)
    get :create, params: {'id' => @user, 'user' => { 'name' => "My Name", 'email' => "this@my.email", 'password' => "password", 'password_confirmation' => "password"}}
		assert_equal 302, response.status
    assert_response :redirect
		assert_redirected_to root_path
	end	
	
	
	#User logged in don't care (correct) admin
	####################################################	
	
	test "logged in, don't care, admin should index" do
		log_in_as(@user_admin)
    get :index
		assert_equal 200, response.status
    assert_response :success
		assert_select 'h1', text: "All users", count: 1		
  end	
	
	test "logged in, don't care, admin should not new" do
		log_in_as(@user_admin)
    get :new
		assert_equal 302, response.status
    assert_response :redirect
		assert_redirected_to root_path
  end	
	
	test "logged in, don't care, admin should not create" do
		log_in_as(@user_admin)
    get :create, params: {'id' => @user, 'user' => { 'name' => "My Name", 'email' => "this@my.email", 'password' => "password", 'password_confirmation' => "password"}}
		assert_equal 302, response.status
    assert_response :redirect
		assert_redirected_to root_path
	end
	
	
	#User logged in, not correct, not admin
	####################################################
	
	test "logged in, not correct, not admin should not show" do
		log_in_as(@user_notadmin)
    get :show, params: {'id' => @user}
		assert_equal 302, response.status
    assert_response :redirect
		assert_not flash.empty?
		assert_equal "Log in as a right user!", flash[:danger]
		assert_redirected_to root_path
  end
	
	test "logged in, not correct, not admin should not edit" do
		log_in_as(@user_notadmin)
		get :edit, params: {'id' => @user}
    assert_response :redirect
		assert_redirected_to root_url
		assert_not flash.empty?
		assert_equal "Log in as a right user!", flash[:danger] 
	end
	
	test "logged in, not correct, not admin should not update" do
		log_in_as(@user_notadmin)
		patch :update, params: {'id' => @user.id, 'user' => { 'name' => @user.name, 'email' => @user.email }}
		assert_equal 302, response.status
    assert_response :redirect
		assert_redirected_to root_url
		assert_not flash.empty?		
		assert_equal "Log in as a right user!", flash[:danger] 
	end
	
	test "logged in, not correct, not admin should not destroy" do
		log_in_as(@user_notadmin)
		assert_no_difference 'User.count' do
			delete :destroy, params: {'id' => @user}
		end
		assert_equal 302, response.status
    assert_response :redirect
		assert_redirected_to root_url
	end		
	
	
	#User logged in, correct, not admin
	####################################################
	
	test "logged in, correct, not admin should show" do
		log_in_as(@user_notadmin)
    get :show, params: {'id' => @user_notadmin}
		assert_equal 200, response.status
    assert_response :success
		assert_select 'h1', text: @user_notadmin.name, count: 1
  end
	
	test "logged in, correct, not admin should edit" do
		log_in_as(@user_notadmin)
		get :edit, params: {'id' => @user_notadmin}
		assert_equal 200, response.status
    assert_response :success
		assert_select 'h1', text: "Update your profile", count: 1
	end
	
	test "logged in, correct, not admin should update" do
		log_in_as(@user_notadmin)
		patch :update, params: {'id' => @user_notadmin, 'user' => { 'name' => @user_notadmin.name, 'email' => @user_notadmin.email }}
		assert_equal 302, response.status
    assert_response :redirect
		#assert_match "fdsfsdfdsf", response.body
		assert_not flash.empty?		
		assert_equal "Nice Chose, Welcome back!", flash[:success]  
	end
	
	test "logged in, correct, not admin should not destroy" do
		log_in_as(@user_notadmin)
		assert_no_difference 'User.count' do
			delete :destroy, params: {'id' => @user_notadmin}
		end
		assert_equal 302, response.status
		assert_response :redirect
		assert_redirected_to root_url		
	end	
	
	
	
		
	#User logged in, not correct, admin
	####################################################
	
	test "logged in, not correct, admin should show" do
		log_in_as(@user_admin)
    get :show, params: {'id' => @user}
		assert_equal 200, response.status
    assert_response :success
		assert_select 'h1', text: @user.name, count: 1
  end
	
	test "logged in, not correct, admin should edit" do
		log_in_as(@user_admin)
		get :edit, params: {'id' => @user}
		assert_equal 200, response.status
    assert_response :success
		assert_select 'h1', "Update your profile", count: 1
	end
	
	test "logged in, not correct, admin should update" do
		log_in_as(@user_admin)
		patch :update, params: {'id' => @user.id, 'user' => { 'name' => @user.name, 'email' => @user.email }}
		assert_equal 302, response.status
    assert_response :redirect
		assert_not flash.empty?		
		assert_equal "Nice Chose, Boss!", flash[:success] 
	end
	
	test "logged in, not correct, admin should destroy" do
		log_in_as(@user_admin)
		assert_difference 'User.count', -1 do
			delete :destroy, params: {'id' => @user}
		end
		assert_equal 302, response.status
    assert_response :redirect
		assert_not flash.empty?		
		assert_equal "Yes it was a bad guy, Boss!", flash[:success] 
	end	
		
	#User logged in, correct, admin
	####################################################
	
	test "logged in, correct, admin should show" do
		log_in_as(@user_admin)
    get :show, params: {'id' => @user_admin}
		assert_equal 200, response.status
    assert_response :success
		assert_select 'h1', text: @user_admin.name, count: 1
  end
	
	test "logged in, correct, admin should edit" do
		log_in_as(@user_admin)
		get :edit, params: {'id' => @user_admin}
		assert_equal 200, response.status
    assert_response :success
		assert_select 'h1', "Update your profile", count: 1
	end
	
	test "logged in, correct, admin should update" do
		log_in_as(@user_admin)
		patch :update, params: {'id' => @user_admin.id, 'user' => { 'name' => @user_admin.name, 'email' => @user_admin.email }}
		assert_equal 302, response.status
		#assert_match "fdsfsdfdsf", response.body
    assert_response :redirect
		assert_not flash.empty?		
		assert_equal "As usual, Nice Chose, Boss!", flash[:success] 
	end
	
	test "logged in, correct, admin should not destroy" do
		log_in_as(@user_admin)
		assert_no_difference 'User.count' do
			delete :destroy, params: {'id' => @user_admin}
		end
		assert_equal 302, response.status
    assert_response :redirect
		assert_not flash.empty?		
		assert_equal "You can't do it for yourself, Boss!", flash[:danger] 
	end	
	
	
	
	#update_attributes - test
	
	test "should not allow the admin attribute to be edited via the web" do
		log_in_as(@user_notadmin)
		assert_not @user_notadmin.admin?
		patch :update, params: {'id' => @user_notadmin, 'user' => { 'password' => "password", 'password_confirmation' => "password", 'admin' => true }}
		assert_not @user_notadmin.admin?
	end
	
	test "should redirect following when not logged in" do
		get :following, params: {'id' => @user}
		assert_redirected_to login_url
	end
	
	test "should redirect followers when not logged in" do
		get :followers, params: {'id' => @user}
		assert_redirected_to login_url
	end
	
end
