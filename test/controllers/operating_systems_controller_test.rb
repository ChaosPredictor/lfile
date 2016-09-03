require 'test_helper'

class OperatingSystemsControllerTest < ActionController::TestCase

	def setup
		@os                   = operating_systems(:linux)
		@user_notadmin        = users(:archer)
	end
	
	test "should get new" do
    get :new
    assert_response :success
  end
	
	test "should redirect edit when not logged in" do
		get :edit, id: @os
		assert_not flash.empty?
		assert_redirected_to login_url
		assert_equal flash[:danger], "Please log in."
	end

	test "should redirect create when not logged in" do
		patch :create, id: @os, user: { name: @os.name, version: "14.04" }
		assert_not flash.empty?
		assert_redirected_to login_url
		assert_equal flash[:danger], "Please log in."
	end
	
	test "should redirect update when not logged in" do
		patch :update, id: @os, user: { name: @os.name, version: "14.04" }
		assert_not flash.empty?
		assert_redirected_to login_url
		assert_equal flash[:danger], "Please log in."
	end	
	
#	test "should redirect edit when not admin" do
#		log_in_as(@user_notadmin)		
#		get :edit, id: @os
#		assert_not flash.empty?
#		assert_redirected_to login_url
#		assert_equal flash[:danger], "Please log in."
#	end

#	test "should redirect create when not admin" do
#		log_in_as(@user_notadmin)
#		patch :create, id: @os, user: { name: @os.name, version: "14.04" }
#		assert_not flash.empty?
#		assert_redirected_to login_url
#		assert_equal flash[:danger], "Please log in."
#	end
	
#	test "should redirect update when not admin" do
#		log_in_as(@user_notadmin)
#		patch :update, id: @os, user: { name: @os.name, version: "14.04" }
#		assert_not flash.empty?
#		assert_redirected_to login_url
#		assert_equal flash[:danger], "Please log in."
#	end
	
	
end
