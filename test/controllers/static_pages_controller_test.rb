require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
	
	def setup
		@base_title = "Linux Apps Installer"
		@user_notadmin        = users(:archer)
		@user_admin           = users(:michael)
	end
			
	
	#User Not logged in
	####################################################
	
  test "should get home for not logged in user" do
    get :home
    assert_response :success
		assert_select "title", "Home | #{@base_title}"				
  end

  test "should get help for not logged in user" do
    get :help
    assert_response :success
		assert_select "title", "Help | #{@base_title}"				
  end

  test "should get about for not logged in user" do
    get :about
    assert_response :success
		assert_select "title", "About | #{@base_title}"		
	end

  test "should get contact for not logged in user" do
    get :contact
    assert_response :success
		assert_select "title", "Contact | #{@base_title}"		
  end


	#User logged in, not admin
	####################################################
	
  test "should get home for logged in user, not admin" do
		log_in_as(@user_notadmin)
    get :home
    assert_response :success
		assert_select "title", "Home | #{@base_title}"				
  end

  test "should get help for logged in user, not admin" do
		log_in_as(@user_notadmin)
		get :help
    assert_response :success
		assert_select "title", "Help | #{@base_title}"				
  end

  test "should get about for logged in user, not admin" do
		log_in_as(@user_notadmin)		
    get :about
    assert_response :success
		assert_select "title", "About | #{@base_title}"		
	end

  test "should get contact for logged in user, not admin" do
		log_in_as(@user_notadmin)		
    get :contact
    assert_response :success
		assert_select "title", "Contact | #{@base_title}"		
  end
	
	#User logged admin
	####################################################
	
  test "should get home for logged admin" do
		log_in_as(@user_admin)
    get :home
    assert_response :success
		assert_select "title", "Home | #{@base_title}"				
  end

  test "should get help for logged admin" do
		log_in_as(@user_admin)
		get :help
    assert_response :success
		assert_select "title", "Help | #{@base_title}"				
  end

  test "should get about for logged admin" do
		log_in_as(@user_admin)		
    get :about
    assert_response :success
		assert_select "title", "About | #{@base_title}"		
	end

  test "should get contact for logged admin" do
		log_in_as(@user_admin)		
    get :contact
    assert_response :success
		assert_select "title", "Contact | #{@base_title}"		
  end

end
