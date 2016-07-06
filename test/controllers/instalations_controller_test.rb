require 'test_helper'

class InstalationsControllerTest < ActionController::TestCase
	def setup
		@instalation      = instalations(:gimp)
		@user_admin       = users(:michael)
		@user_notadmin    = users(:archer)		
	end
	
  test "should get new only if login" do
		#get :new
		assert_no_difference 'Instalation.count' do
			post :create, instalation: { name: "Lorem", version: "1.1", os: "new" }
		end
		assert_response :redirect
		assert_redirected_to login_url
		log_in_as(@user_admin)
		#get :new
		assert_difference 'Instalation.count' do
			post :create, instalation: { name: "Lorem", version: "1.1", os: "new" }
		end
		assert_equal flash[:success], "New Instalation Saved!!!"
		assert_response :redirect
		assert_redirected_to instalations_path
  end
	
	test "should create when admin" do
		log_in_as(@user_admin)
		assert_difference 'Instalation.count', 1 do
			post :create, instalation: { name: "Lorem", version: "1.1", os: "new" }
		end
		assert_redirected_to instalations_path
	end
	
	test "should create when logged in" do
		log_in_as(@user_notadmin)
		assert_difference 'Instalation.count', 1 do
			post :create, instalation: { name: "Lorem", version: "1.1", os: "new" }
		end
		assert_redirected_to instalations_path
	end
	
	test "should redirect create when not logged in" do
		assert_no_difference 'Instalation.count' do
			post :create, instalation: { name: "Lorem", version: "1.1", os: "new" }
		end
		assert_redirected_to login_url
	end
	
	test "should redirect destroy when not logged in" do
		assert_no_difference 'Instalation.count' do
			delete :destroy, id: @instalation
		end
		assert_redirected_to login_url
	end
	
	test "should redirect destroy for not admin user" do
		log_in_as(users(:archer))
		instalation = instalations(:firefox)
		assert_no_difference 'Instalation.count' do
			delete :destroy, id: instalation
		end
		assert_redirected_to root_url
	end
	
	test "should destroy for admin user" do		
		log_in_as(users(:michael))
		@instalation = instalations(:gimp)
		assert_difference 'Instalation.count', -1 do
			delete :destroy, id: @instalation
		end
		assert_redirected_to instalations_path
	end
	
	test "should edit for admin user" do		
		log_in_as(users(:michael))
		@instalation = Instalation.first
		assert_no_difference 'Instalation.count' do
			patch :update, id: @instalation, instalation: {name: "PIMG", 
																											version: @instalation.version, 
																											os: @instalation.os}
		end
		assert_redirected_to instalations_path
		@instalation2 = Instalation.first
		assert_match @instalation2.name, "PIMG"
	end
	
	test "should not edit for not admin user" do		
		log_in_as(users(:archer))
		@instalation = Instalation.first
		assert_no_difference 'Instalation.count' do
			patch :update, id: @instalation, instalation: {name: "PIMG", 
																											version: @instalation.version, 
																											os: @instalation.os}
		end
		assert_redirected_to root_path
		@instalation2 = Instalation.first
		assert_match @instalation2.name, "GIMP"
	end
	
	test "should not edit for not logedin" do		
		@instalation = Instalation.first
		assert_no_difference 'Instalation.count' do
			patch :update, id: @instalation, instalation: {name: "PIMG", 
																											version: @instalation.version, 
																											os: @instalation.os}
		end
		assert_redirected_to login_path
		@instalation2 = Instalation.first
		assert_match @instalation2.name, "GIMP"
	end
	
end
