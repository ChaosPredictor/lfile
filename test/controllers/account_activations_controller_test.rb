require 'test_helper'

class AccountActivationsControllerTest < ActionController::TestCase
	def setup
		@user_admin            = users(:michael)
		@user_notadmin         = users(:archer)
		@user                  = users(:lana)		
	end
	
	# Edit
	#########################################################
	
	test "valid activation_digest, should edit" do
		get :edit, id: "2tP7ERFoyrtlgniX5CEMPA", email: @user.email
    assert_response :redirect
		assert_redirected_to @user
		assert_not flash.empty?
		assert_equal "Account activated!", flash[:success]
	end
	
	test "invalid activation_digest, should not edit" do
		get :edit, id: "2tP7ERFoyrtlgniX5CEMPB", email: @user.email
    assert_response :redirect
		assert_redirected_to root_path
		assert_not flash.empty?
		assert_equal "Invalid activation link", flash[:danger]
	end
	
	#Update
	##################################################################
	
	test "logged in admin, should update" do
		log_in_as(@user_admin)
		get :update, id: @user.email
		assert_response :redirect
		assert_redirected_to @user
		assert_not flash.empty?
		assert_equal "#{@user.name} Account activated!", flash[:success]
	end
	
	test "logged in not admin, should not update" do
		log_in_as(@user_notadmin)
		get :update, id: @user.email
		assert_response :redirect
		assert_redirected_to root_path
		assert_not flash.empty?
		assert_equal "It's not for you!", flash[:danger]
	end
	
	test "not logged in, should not update" do
		get :update, id: @user.email
		assert_response :redirect
		assert_redirected_to root_path
		assert_not flash.empty?
		assert_equal "It's not for you!", flash[:danger]
	end
	
	
#	test "should redirect destroy when not logged in" do
#		assert_no_difference 'User.count' do
#			delete :destroy, id: @user
#		end
#    assert_response :redirect
#		assert_redirected_to login_url
#		assert_equal flash[:danger], "Please log in."
#	end
#	
#	#User logged in don't care (Correct) not admin
#	####################################################	
#	
#	test "logged in, don't care, not admin should index" do
#		log_in_as(@user_notadmin)
#    get :index
#		assert_equal 200, response.status
#    assert_response :success
#		assert_select 'h1', text: "All users", count: 1		
#  end	
#	
#	test "logged in, don't care, not admin should not new" do
#		log_in_as(@user_notadmin)
#    get :new
#		assert_equal 302, response.status
#    assert_response :redirect
#		assert_redirected_to root_path
#  end	
#	
#	test "logged in, don't care, not admin should not create" do
#		log_in_as(@user_notadmin)
#    get :create, id: @user, user: { name: "My Name", email: "this@my.email", password: "password", password_confirmation: "password"}
#		assert_equal 302, response.status
#    assert_response :redirect
#		assert_redirected_to root_path
#	end	
#	
#	
#	#User logged in don't care (correct) admin
#	####################################################	
#	
#	test "logged in, don't care, admin should index" do
#		log_in_as(@user_admin)
#    get :index
#		assert_equal 200, response.status
#    assert_response :success
#		assert_select 'h1', text: "All users", count: 1		
#  end	
#	
#	test "logged in, don't care, admin should not new" do
#		log_in_as(@user_admin)
#    get :new
#		assert_equal 302, response.status
#    assert_response :redirect
#		assert_redirected_to root_path
#  end	
#	
#	test "logged in, don't care, admin should not create" do
#		log_in_as(@user_admin)
#    get :create, id: @user, user: { name: "My Name", email: "this@my.email", password: "password", password_confirmation: "password"}
#		assert_equal 302, response.status
#    assert_response :redirect
#		assert_redirected_to root_path
#	end
#	
#	
#	#User logged in, not correct, not admin
#	####################################################
#	
#	test "logged in, not correct, not admin should not show" do
#		log_in_as(@user_notadmin)
#    get :show, id: @user
#		assert_equal 302, response.status
#    assert_response :redirect
#		assert_not flash.empty?
#		assert_equal "Log in as a right user!", flash[:danger]
#		assert_redirected_to root_path
#  end
#	
#	test "logged in, not correct, not admin should not edit" do
#		log_in_as(@user_notadmin)
#		get :edit, id: @user
#    assert_response :redirect
#		assert_redirected_to root_url
#		assert_not flash.empty?
#		assert_equal "Log in as a right user!", flash[:danger] 
#	end
#	
#	test "logged in, not correct, not admin should not update" do
#		log_in_as(@user_notadmin)
#		patch :update, id: @user.id, user: { name: @user.name, email: @user.email }
#		assert_equal 302, response.status
#    assert_response :redirect
#		assert_redirected_to root_url
#		assert_not flash.empty?		
#		assert_equal "Log in as a right user!", flash[:danger] 
#	end
#	
#	test "logged in, not correct, not admin should not destroy" do
#		log_in_as(@user_notadmin)
#		assert_no_difference 'User.count' do
#			delete :destroy, id: @user
#		end
#		assert_equal 302, response.status
#    assert_response :redirect
#		assert_redirected_to root_url
#	end		
#	
#	
#	#User logged in, correct, not admin
#	####################################################
#	
#	test "logged in, correct, not admin should show" do
#		log_in_as(@user_notadmin)
#    get :show, id: @user_notadmin
#		assert_equal 200, response.status
#    assert_response :success
#		assert_select 'h1', text: @user_notadmin.name, count: 1
#  end
#	
#	test "logged in, correct, not admin should edit" do
#		log_in_as(@user_notadmin)
#		get :edit, id: @user_notadmin
#		assert_equal 200, response.status
#    assert_response :success
#		assert_select 'h1', text: "Update your profile", count: 1
#	end
#	
#	test "logged in, correct, not admin should update" do
#		log_in_as(@user_notadmin)
#		patch :update, id: @user_notadmin, user: { name: @user_notadmin.name, email: @user_notadmin.email }
#		assert_equal 302, response.status
#    assert_response :redirect
#		#assert_match "fdsfsdfdsf", response.body
#		assert_not flash.empty?		
#		assert_equal "Nice Chose, Welcome back!", flash[:success]  
#	end
#	
#	test "logged in, correct, not admin should not destroy" do
#		log_in_as(@user_notadmin)
#		assert_no_difference 'User.count' do
#			delete :destroy, id: @user_notadmin
#		end
#		assert_equal 302, response.status
#		assert_response :redirect
#		assert_redirected_to root_url		
#	end	
#	
#	
#	
#		
#	#User logged in, not correct, admin
#	####################################################
#	
#	test "logged in, not correct, admin should show" do
#		log_in_as(@user_admin)
#    get :show, id: @user
#		assert_equal 200, response.status
#    assert_response :success
#		assert_select 'h1', text: @user.name, count: 1
#  end
#	
#	test "logged in, not correct, admin should edit" do
#		log_in_as(@user_admin)
#		get :edit, id: @user
#		assert_equal 200, response.status
#    assert_response :success
#		assert_select 'h1', "Update your profile", count: 1
#	end
#	
#	test "logged in, not correct, admin should update" do
#		log_in_as(@user_admin)
#		patch :update, id: @user.id, user: { name: @user.name, email: @user.email }
#		assert_equal 302, response.status
#    assert_response :redirect
#		assert_not flash.empty?		
#		assert_equal "Nice Chose, Boss!", flash[:success] 
#	end
#	
#	test "logged in, not correct, admin should destroy" do
#		log_in_as(@user_admin)
#		assert_difference 'User.count', -1 do
#			delete :destroy, id: @user
#		end
#		assert_equal 302, response.status
#    assert_response :redirect
#		assert_not flash.empty?		
#		assert_equal "Yes it was a bad guy, Boss!", flash[:success] 
#	end	
#		
#	#User logged in, correct, admin
#	####################################################
#	
#	test "logged in, correct, admin should show" do
#		log_in_as(@user_admin)
#    get :show, id: @user_admin
#		assert_equal 200, response.status
#    assert_response :success
#		assert_select 'h1', text: @user_admin.name, count: 1
#  end
#	
#	test "logged in, correct, admin should edit" do
#		log_in_as(@user_admin)
#		get :edit, id: @user_admin
#		assert_equal 200, response.status
#    assert_response :success
#		assert_select 'h1', "Update your profile", count: 1
#	end
#	
#	test "logged in, correct, admin should update" do
#		log_in_as(@user_admin)
#		patch :update, id: @user_admin.id, user: { name: @user_admin.name, email: @user_admin.email }
#		assert_equal 302, response.status
#		#assert_match "fdsfsdfdsf", response.body
#    assert_response :redirect
#		assert_not flash.empty?		
#		assert_equal "As usual, Nice Chose, Boss!", flash[:success] 
#	end
#	
#	test "logged in, correct, admin should not destroy" do
#		log_in_as(@user_admin)
#		assert_no_difference 'User.count' do
#			delete :destroy, id: @user_admin
#		end
#		assert_equal 302, response.status
#    assert_response :redirect
#		assert_not flash.empty?		
#		assert_equal "You can't do it for yourself, Boss!", flash[:danger] 
#	end	
#	
#	
#	
#	#update_attributes - test
#	
#	test "should not allow the admin attribute to be edited via the web" do
#		log_in_as(@user_notadmin)
#		assert_not @user_notadmin.admin?
#		patch :update, id: @user_notadmin, user: { password: "password", 
#																						password_confirmation: "password",
#																						admin: true }
#		assert_not @user_notadmin.admin?
#	end
#	
#	test "should redirect following when not logged in" do
#		get :following, id: @user
#		assert_redirected_to login_url
#	end
#	
#	test "should redirect followers when not logged in" do
#		get :followers, id: @user
#		assert_redirected_to login_url
#	end
	
end
