require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  
	def setup
		#@user_admin            = users(:michael)
		#@user_notadmin         = users(:archer)
		@user_activ              = User.create( name: "Lana Keemail", email: "has@example.gov", password: 'password3', activated: true )
		@user_unactiv            = User.create( name: "Lana Second", email: "hand@examp.gov", password: 'password4', activated: false )
	end
	
	#Create
	######################################
	
	test "activated user right password" do
		#post :create, "session" => { "email" => @user_activ.email, "password" => @user_activ.password }
		post :create, params: {"session" => { "email" => @user_activ.email, "password" => @user_activ.password }}
		
		#post :login, session: { email: "user@user.email", password: @user_activ.password }
		#post login_path, session: { email: @user_activ.email, password: @user_activ.password }
		#post password_resets_path, password_reset: { email: "" }
		#post :create, micropost: { content: "Lorem ipsum" }
		assert_equal 302, response.status
		assert_response :redirect
		#assert_redirected_to "/users/#{@user_activ.id}"
		assert_redirected_to root_path
    assert_not flash.empty?
		assert_equal  "You're right, man", flash[:success]
  end
	
	test "activated user wrong password" do
		#post :create, "session" => { "email" => @user_activ.email, "password" => "password2" }
		post :create, params: {"session" => { "email" => @user_activ.email, "password" => "password2" }}
		#get :create, id: @session, session: { email: @user_activ.email, password: "password2" }
 		assert_equal 200, response.status
		assert_response :success
		assert_not flash.empty?
		assert_equal  "Invalid email/password combination", flash[:danger]
  end
	
	test "unactivated user right password" do
		#post :create, "session" => { "email" => @user_unactiv.email, "password" => @user_unactiv.password }
		post :create, params: {"session" => { "email" => @user_unactiv.email, "password" => @user_unactiv.password }}
		#get :create, id: @session, session: { email: @user_unactiv.email, password: @user_unactiv.password }
    assert_not flash.empty?
		assert_equal 302, response.status
		assert_response :redirect
		assert_redirected_to root_path
		assert_equal  "Account not activated. Check your email for the activation link.", flash[:warning]
		assert_equal  "If you can not find the email <a rel=\"nofollow\" data-method=\"post\" href=\"/resend_activation/hand@examp.gov\">Click Here</a> to get a new one", flash[:info]
  end
	
	test "unactivated user wrong password" do
		post :create, params: {"session" => { "email" => @user_unactiv.email, "password" => "password2" }}
		#get :create, id: @session, session: { email: @user_unactiv.email, password: "password2" }
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
		delete :destroy, params: {'id' => @session}
		assert_equal 302, response.status
		assert_response :redirect
		assert_redirected_to root_path
		assert_not flash.empty?
		assert_equal  "Hope to see you soon!!!", flash[:info]		
	end
	
end
