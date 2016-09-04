require 'test_helper'

class OperatingSystemsControllerTest < ActionController::TestCase

	def setup
		@os                   = operating_systems(:linux)
		@user_notadmin        = users(:archer)
	end
	
	test "should not get index for not logged in user" do
    get :index
		assert_not flash.empty?
		assert_equal flash[:danger], "Please log in."
  end
	
	test "should not get show for not logged in user" do
    get :show, id: @os
		assert_not flash.empty?
		assert_equal flash[:danger], "Please log in."
  end
	
	test "should not get new for not logged in user" do
    get :new
		assert_not flash.empty?
		assert_equal flash[:danger], "Please log in."
  end
	
	test "should not get create for not logged in user" do
    patch :create, id: @os, operating_system: { name: @os.name, version: "14.04" }
		assert_not flash.empty?
		#assert_equal flash[:success], "Please log in."		
		assert_equal flash[:danger], "Please log in."
  end

	test "should not get edit for not logged in user" do
		get :edit, id: @os
		assert_not flash.empty?
		assert_equal flash[:danger], "Please log in."
  end
	
	test "should not get update for not logged in user" do
		patch :update, id: @os, operating_system: { name: @os.name, version: "14.04" }
		assert_not flash.empty?
		assert_equal flash[:danger], "Please log in."
  end
	
	test "should not get delete for not logged in user" do
		delete :destroy, id: @os.id
		assert_not flash.empty?
		assert_equal flash[:danger], "Please log in."
  end

	
	#test "should redirect edit when not logged in" do
	#	get :edit, id: @os
	#	assert_not flash.empty?
	#	assert_redirected_to login_url
	#	assert_equal flash[:danger], "Please log in."
	#end

	#test "should redirect create when not logged in" do
	#	patch :create, id: @os, operating_system: { name: @os.name, version: "14.04" }
	#	assert_not flash.empty?
	#	assert_redirected_to login_url
	#	assert_equal flash[:danger], "Please log in."
	#end
	
	#test "should redirect update when not logged in" do
	#	patch :update, id: @os, operating_system: { name: @os.name, version: "14.04" }
	#	assert_not flash.empty?
	#	assert_redirected_to login_url
	#	assert_equal flash[:danger], "Please log in."
	#end	
	
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
