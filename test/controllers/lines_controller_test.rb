require 'test_helper'

class LinesControllerTest < ActionController::TestCase
	def setup
		@instalation      = instalations(:gimp)
		@user_admin       = users(:michael)
		@user_notadmin    = users(:archer)		
	end
	
  test "should not add line" do
		assert_no_difference 'Line.count' do
			post :create, line: { content: "line for test", index: 1}
		end
		assert_response :redirect
		assert_redirected_to login_url
		
		log_in_as(@user_notadmin)
		assert_no_difference 'Line.count' do
			post :create, line: { content: "line for test", index: 1}
		end
		#TODO assert_equal flash[:error], "Only Admin can add line"
		#assert_response :redirect
		#get lines_path
		assert_redirected_to root_path
		#TODO assert_redirected_to lines_path		
	end
	
	test "should add only if admin" do
		#TODO logout_path()
		
		log_in_as(@user_admin)
		assert_difference 'Line.count', 1 do
			post :create, line: { content: "line for test2", index: 131}
		end
		assert_equal flash[:success], "New Line Saved!!!"
		assert_response :redirect
		assert_redirected_to lines_path
  end
	
#	test "should create when admin" do
#		log_in_as(@user_admin)
#		assert_difference 'Instalation.count', 1 do
#			post :create, instalation: { name: "Lorem", version: "1.1", os: "new" }
#		end
#		assert_redirected_to instalations_path
#	end
#	
#	test "should create when logged in" do
#		log_in_as(@user_notadmin)
#		assert_difference 'Instalation.count', 1 do
#			post :create, instalation: { name: "Lorem", version: "1.1", os: "new" }
#		end
#		assert_redirected_to instalations_path
#	end
#	
#	test "should redirect create when not logged in" do
#		assert_no_difference 'Instalation.count' do
#			post :create, instalation: { name: "Lorem", version: "1.1", os: "new" }
#		end
#		assert_redirected_to login_url
#	end
#	
#	test "should redirect destroy when not logged in" do
#		assert_no_difference 'Instalation.count' do
#			delete :destroy, id: @instalation
#		end
#		assert_redirected_to login_url
#	end
#	
#	test "should redirect destroy for not admin user" do
#		log_in_as(users(:archer))
#		instalation = instalations(:firefox)
#		assert_no_difference 'Instalation.count' do
#			delete :destroy, id: instalation
#		end
#		assert_redirected_to root_url
#	end
#	
#	test "should destroy for admin user" do		
#		log_in_as(users(:michael))
#		@instalation = instalations(:gimp)
#		assert_difference 'Instalation.count', -1 do
#			delete :destroy, id: @instalation
#		end
#		assert_redirected_to instalations_path
#	end
#	
#	test "should edit for admin user" do		
#		log_in_as(users(:michael))
#		@instalation = Instalation.first
#		assert_no_difference 'Instalation.count' do
#			patch :update, id: @instalation, instalation: {name: "PIMG", 
#																											version: @instalation.version, 
#																											os: @instalation.os}
#		end
#		assert_redirected_to instalations_path
#		@instalation2 = Instalation.first
#		assert_match @instalation2.name, "PIMG"
#	end
#	
#	test "should not edit for not admin user" do		
#		log_in_as(users(:archer))
#		@instalation = Instalation.first
#		assert_no_difference 'Instalation.count' do
#			patch :update, id: @instalation, instalation: {name: "PIMG", 
#																											version: @instalation.version, 
#																											os: @instalation.os}
#		end
#		assert_redirected_to root_path
#		@instalation2 = Instalation.first
#		assert_match @instalation2.name, "GIMP"
#	end
#	
#	test "should not edit for not logedin" do		
#		@instalation = Instalation.first
#		assert_no_difference 'Instalation.count' do
#			patch :update, id: @instalation, instalation: {name: "PIMG", 
#																											version: @instalation.version, 
#																											os: @instalation.os}
#		end
#		assert_redirected_to login_path
#		@instalation2 = Instalation.first
#		assert_match @instalation2.name, "GIMP"
#	end
#	
#	
#	test "open instalation link as admin user" do		
#		log_in_as(users(:michael))
#		@instalation = instalations(:gimp)
#		get :show, id: @instalation
#		assert_select 'a', text: 'delete', count: 1
#		assert_select 'a', text: 'edit', count: 1
#		assert_select 'h1', text: 'GIMP', count: 1		
#		assert_select 'h2 div#version', text: 'Vession: 1.1', count: 1		
#		assert_select 'h2 div#os', text: 'Operation System: linux', count: 1		
#	end
#	
#	test "open instalation link as not admin user" do		
#		log_in_as(users(:archer))
#		@instalation = instalations(:gimp)
#		get :show, id: @instalation
#		assert_select 'a', text: 'delete', count: 0
#		assert_select 'a', text: 'edit', count: 0
#		assert_select 'h1', text: 'GIMP', count: 1		
#		assert_select 'h2 div#version', text: 'Vession: 1.1', count: 1		
#		assert_select 'h2 div#os', text: 'Operation System: linux', count: 1		
#	end
end
