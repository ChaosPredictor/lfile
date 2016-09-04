require 'test_helper'

class OperatingSystemsControllerTest < ActionController::TestCase

	def setup
		@os                   = operating_systems(:linux)
		@user_notadmin        = users(:archer)
		@user_admin           = users(:michael)		
	end
	
	#User Not logged in
	####################################################
	
	test "should not get index for not logged in user" do
    get :index
		assert_not flash.empty?
		assert_equal  "Please log in.", flash[:danger]
  end
	
	test "should not get show for not logged in user" do
    get :show, id: @os
		assert_not flash.empty?
		assert_equal  "Please log in.", flash[:danger]
  end
	
	test "should not get new for not logged in user" do
    get :new
		assert_not flash.empty?
		assert_equal  "Please log in.", flash[:danger]
  end
	
	test "should not get create for not logged in user" do
    patch :create, id: @os, operating_system: { name: @os.name, version: "14.04" }
		assert_not flash.empty?
		#assert_equal flash[:success], "Please log in."		
		assert_equal  "Please log in.", flash[:danger]
  end

	test "should not get edit for not logged in user" do
		get :edit, id: @os
		assert_not flash.empty?
		assert_equal  "Please log in.", flash[:danger]
  end
	
	test "should not get update for not logged in user" do
		patch :update, id: @os, operating_system: { name: @os.name, version: "14.04" }
		assert_not flash.empty?
		assert_equal  "Please log in.", flash[:danger]
  end
	
	test "should not get delete for not logged in user" do
		delete :destroy, id: @os.id
		assert_not flash.empty?
		assert_equal  "Please log in.", flash[:danger]
  end

	#User logged in, not admin
	####################################################
	
	test "should get index for logged in user, not admin" do
		log_in_as(@user_notadmin)
    get :index
		assert_equal 200, response.status		
		assert_select 'h1', value: "Operating System list", count: 1	
  end
	
	test "should not get show for logged in user, not admin" do
		log_in_as(@user_notadmin)
    get :show, id: @os
		assert_equal 302, response.status		
		assert_redirected_to root_path
  end
	
	test "should not get new for logged in user, not admin" do
		log_in_as(@user_notadmin)
    get :new
		assert_equal 302, response.status				
		assert_redirected_to root_path
  end
	
	test "should not get create for logged in user, not admin" do
		log_in_as(@user_notadmin)
    patch :create, id: @os, operating_system: { name: @os.name, version: "14.04" }
		assert_equal 302, response.status				
		assert_redirected_to root_path
  end

	test "should not get edit for logged in user, not adminr" do
		log_in_as(@user_notadmin)
		get :edit, id: @os
		assert_equal 302, response.status				
		assert_redirected_to root_path
  end
	
	test "should not get update for logged in user, not admin" do
		log_in_as(@user_notadmin)
		patch :update, id: @os, operating_system: { name: @os.name, version: "14.04" }
		assert_equal 302, response.status				
		assert_redirected_to root_path
  end
	
	test "should not get delete for logged in user, not admin" do
		log_in_as(@user_notadmin)
		delete :destroy, id: @os.id
		assert_equal 302, response.status				
		assert_redirected_to root_path
  end

	#User logged admin
	####################################################
	
	test "should get index for logged admin" do
		log_in_as(@user_admin)
    get :index
		assert_equal 200, response.status		
		assert_select 'h1', value: "Operating System list", count: 1	
  end
	
	test "should not get show for logged admin" do
		log_in_as(@user_admin)
    get :show, id: @os.id
		assert_equal 200, response.status
		assert_select 'h1', text: "Orepating System: " + String(@os.name), count: 1		
  end
	
	test "should not get new for logged admin" do
		log_in_as(@user_admin)
    get :new
		assert_equal 200, response.status
		assert_select 'h1', text: "Add Operating System", count: 1
  end
	
	test "should not get create for logged admin" do
		log_in_as(@user_admin)
    patch :create, id: @os, operating_system: { name: @os.name, version: "14.04" }
		assert_equal 302, response.status
		assert_redirected_to operating_systems_path
		assert_not flash.empty?
		assert_equal  "New Operating System/Version added to list!", flash[:success]
  end

	test "should not get edit for logged adminr" do
		log_in_as(@user_admin)
		get :edit, id: @os
		assert_equal 200, response.status
		assert_select 'h1', text: "Edit Operating System", count: 1
	end
	
	test "should not get update for logged admin" do
		log_in_as(@user_admin)
		patch :update, id: @os, operating_system: { name: @os.name, version: "14.04" }
		assert_equal 302, response.status
		assert_redirected_to operating_systems_path
		assert_not flash.empty?
		assert_equal  "Operating System Editted!", flash[:success]
  end
	
	test "should not get delete for logged admin" do
		log_in_as(@user_admin)
		delete :destroy, id: @os.id
		assert_equal 302, response.status
		assert_redirected_to operating_systems_path
		assert_not flash.empty?
		assert_equal  "Operating System Deleted from the list!", flash[:success]
	end

	#		assert_no_match 'Edit Instalation ' + String(@instalation.id) , response.body
end
