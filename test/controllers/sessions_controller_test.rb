require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  
	def setup
		#@user_admin            = users(:michael)
		#@user_notadmin         = users(:archer)
		@user_activ              = User.create( name: "Lana Keemail", email: "has@example.gov", password: 'password3', activated: true )
		@user_unactiv            = User.create( name: "Lana Second", email: "hand@examp.gov", password: 'password4', activated: false )
	end
	
	#Create
	####################################33
	
	test "activated user right password" do
		get :create, id: @session, session: { email: @user_activ.email, password: @user_activ.password }
		assert_equal 302, response.status
		assert_response :redirect
		assert_redirected_to "/users/#{@user_activ.id}"
    assert_not flash.empty?
		assert_equal  "You're right, man", flash[:success]
  end
	
	test "activated user wrong password" do
		get :create, id: @session, session: { email: @user_activ.email, password: "password2" }
 		assert_equal 200, response.status
		assert_response :success
		assert_not flash.empty?
		assert_equal  "Invalid email/password combination", flash[:danger]
  end
	
	test "unactivated user right password" do
		get :create, id: @session, session: { email: @user_unactiv.email, password: @user_unactiv.password }
    assert_not flash.empty?
		assert_equal 302, response.status
		assert_response :redirect
		assert_redirected_to root_path
		assert_equal  "Account not activated. Check your email for the activation link.", flash[:warning]
		assert_equal  "If you can not find the email <a href='/installations'>Click Here</a> to resend", flash[:info]
  end
	
	test "unactivated user wrong password" do
		get :create, id: @session, session: { email: @user_unactiv.email, password: "password2" }
 		assert_equal 200, response.status
		assert_response :success
		assert_not flash.empty?
		assert_equal  "Invalid email/password combination", flash[:danger]
  end
	
	#Destroy
	###########################################
	
	
	test "destroy session" do
		log_in_as(@user_activ)
		assert_equal 200, response.status
		assert_response :success
		delete :destroy, id: @session
		assert_equal 302, response.status
		assert_response :redirect
		assert_redirected_to root_path
		assert_not flash.empty?
		assert_equal  "Hope to see you soon!!!", flash[:info]		
	end
	
end
