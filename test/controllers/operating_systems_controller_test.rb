require 'test_helper'

class OperatingSystemsControllerTest < ActionController::TestCase

	def setup
		@os                   = operating_systems(:linux)
		@user_notadmin        = users(:archer)
		@user_admin           = users(:michael)		
	end
	
	#User Not logged in
	####################################################
	
	test "not logged in should not index" do
    get :index
		assert_equal 302, response.status		
		assert_redirected_to login_path
		assert_not flash.empty?
		assert_equal  "Please log in.", flash[:danger]
  end
	
	test "not logged in should not show" do
    get :show, id: @os
		assert_equal 302, response.status		
		assert_redirected_to login_path
		assert_not flash.empty?
		assert_equal  "Please log in.", flash[:danger]
  end
	
	test "not logged in should not new" do
    get :new
		assert_equal 302, response.status		
		assert_redirected_to login_path
		assert_not flash.empty?
		assert_equal  "Please log in.", flash[:danger]
  end
	
	test "not logged in should not create" do
    patch :create, id: @os, operating_system: { name: @os.name, version: "14.04" }
		assert_equal 302, response.status		
		assert_redirected_to login_path
		assert_not flash.empty?
		assert_equal  "Please log in.", flash[:danger]
  end

	test "not logged in should not edit" do
		get :edit, id: @os
		assert_equal 302, response.status		
		assert_redirected_to login_path
		assert_not flash.empty?
		assert_equal  "Please log in.", flash[:danger]
  end
	
	test "not logged in should not update" do
		patch :update, id: @os, operating_system: { name: @os.name, version: "14.04" }
		assert_equal 302, response.status		
		assert_redirected_to login_path
		assert_not flash.empty?
		assert_equal  "Please log in.", flash[:danger]
  end
	
	test "not logged in should not destroy" do
		delete :destroy, id: @os.id
		assert_equal 302, response.status		
		assert_redirected_to login_path
		assert_not flash.empty?
		assert_equal  "Please log in.", flash[:danger]
  end

	
	#User logged in, not admin
	####################################################
	
	test "logged in, not admin should index" do
		log_in_as(@user_notadmin)
    get :index
		assert_equal 200, response.status		
		assert_select 'h1', value: "Operating System list", count: 1	
  end
	
	test "logged in, not admin should not show" do
		log_in_as(@user_notadmin)
    get :show, id: @os
		assert_equal 302, response.status		
		assert_redirected_to root_path
  end
	
	test "logged in, not admin should not new" do
		log_in_as(@user_notadmin)
    get :new
		assert_equal 302, response.status				
		assert_redirected_to root_path
  end
	
	test "logged in, not admin should not create" do
		log_in_as(@user_notadmin)
    patch :create, id: @os, operating_system: { name: @os.name, version: "14.04" }
		assert_equal 302, response.status				
		assert_redirected_to root_path
  end

	test "logged in, not admin should not edit" do
		log_in_as(@user_notadmin)
		get :edit, id: @os
		assert_equal 302, response.status				
		assert_redirected_to root_path
  end
	
	test "logged in, not admin should not update" do
		log_in_as(@user_notadmin)
		patch :update, id: @os, operating_system: { name: @os.name, version: "14.04" }
		assert_equal 302, response.status				
		assert_redirected_to root_path
  end
	
	test "logged in, not admin should not destroy" do
		log_in_as(@user_notadmin)
		delete :destroy, id: @os.id
		assert_equal 302, response.status				
		assert_redirected_to root_path
  end

	#User logged admin
	####################################################
	
	test "logged in, admin should index" do
		log_in_as(@user_admin)
    get :index
		assert_equal 200, response.status		
		assert_select 'h1', value: "Operating System list", count: 1	
  end
	
	test "logged in, admin should show" do
		log_in_as(@user_admin)
    get :show, id: @os.id
		assert_equal 200, response.status
		assert_select 'h1', text: "Orepating System: " + String(@os.name), count: 1		
  end
	
	test "logged in, admin should new" do
		log_in_as(@user_admin)
    get :new
		assert_equal 200, response.status
		assert_select 'h1', text: "Add Operating System", count: 1
  end
	
	test "logged in, admin should create" do
		log_in_as(@user_admin)
    patch :create, id: @os, operating_system: { name: @os.name, version: "14.04" }
		assert_equal 302, response.status
		assert_redirected_to operating_systems_path
		assert_not flash.empty?
		assert_equal  "New Operating System/Version added to list!", flash[:success]
  end

	test "logged in, admin should edit" do
		log_in_as(@user_admin)
		get :edit, id: @os
		assert_equal 200, response.status
		assert_select 'h1', text: "Edit Operating System", count: 1
	end
	
	test "logged in, admin should update" do
		log_in_as(@user_admin)
		patch :update, id: @os, operating_system: { name: @os.name, version: "14.04" }
		assert_equal 302, response.status
		assert_redirected_to operating_systems_path
		assert_not flash.empty?
		assert_equal  "Operating System Editted!", flash[:success]
  end
	
	test "logged in, admin should destroy" do
		log_in_as(@user_admin)
		delete :destroy, id: @os.id
		assert_equal 302, response.status
		assert_redirected_to operating_systems_path
		assert_not flash.empty?
		assert_equal  "Operating System Deleted from the list!", flash[:success]
	end

	#		assert_no_match 'Edit Instalation ' + String(@instalation.id) , response.body
end
