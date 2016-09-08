require 'test_helper'

class InstallationsControllerTest < ActionController::TestCase
	def setup
		@installation            = installations(:gimp)
		#@installation_notadmin   = installations(:gimp).dup

		@user_admin              = users(:michael)
		@user_notadmin           = users(:archer)
		@user                    = users(:lana)		
		
		@installation.update(user_id: @user.id)
		@installation_notadmin = Installation.create(name: "VLC2", version: "1.11", os: "linux", source_link: "pimg.com", user_id: @user_notadmin.id)
	end
	
	#Not Logged in user
	#######################################
	
	test "not logged in should index" do
		get :index
		assert_equal 200, response.status
    assert_response :success
		assert_select 'h1', text: "All Installations", count: 1
	end

	test "not logged in should not new" do
    get :new
		assert_equal 302, response.status
    assert_response :redirect
		assert_redirected_to login_path
		assert_not flash.empty?
		assert_equal  "Please log in.", flash[:danger]
	end
	
	test "not logged in should not create" do
		assert_no_difference 'Installation.count' do
			get :create, id: @installation, installation: {name: "PMIG", version: "1.1", os: "linux", source_link: "pimg.com", user_id: @user_admin.id}
		end
		assert_equal 302, response.status
    assert_response :redirect
		assert_redirected_to login_path
		assert_not flash.empty?
		assert_equal  "Please log in.", flash[:danger]
	end
	
	test "not logged in should not show" do
    get :show, id: @installation
		assert_equal 302, response.status
    assert_response :redirect
		assert_redirected_to login_path
		assert_not flash.empty?
		assert_equal  "Please log in.", flash[:danger]
	end
	
	test "not logged in should not edit" do
    get :edit, id: @installation
		assert_equal 302, response.status
    assert_response :redirect
		assert_redirected_to login_path
		assert_not flash.empty?
		assert_equal  "Please log in.", flash[:danger]
	end
	
	test "not logged in should not update" do
    patch :update, id: @installation, installation: {  name: "PMIG", version: "1.1", os: "linux", source_link: "pimg.com", user_id: @user_admin.id}
		assert_equal 302, response.status
    assert_response :redirect
		assert_redirected_to login_path
		assert_not flash.empty?
		assert_equal  "Please log in.", flash[:danger]
	end
	
	test "not logged in should not destroy" do
		assert_no_difference 'Installation.count' do
			delete :destroy, id: @installation
		end
		assert_equal 302, response.status
    assert_response :redirect
		assert_redirected_to login_path
		assert_not flash.empty?
		assert_equal  "Please log in.", flash[:danger]
	end
	
	
	#Logged in user, not admin
	#######################################
	
	test "logged in, not admin should index" do
		log_in_as(@user_notadmin)
		get :index
		assert_equal 200, response.status
    assert_response :success
		assert_select 'h1', text: "All Installations", count: 1
	end

	test "logged in, not admin should new" do
		log_in_as(@user_notadmin)
		get :new
		assert_equal 200, response.status
    assert_response :success
		assert_select 'h1', text: "New Installation", count: 1
	end
	
	test "logged in, not admin should create" do
		log_in_as(@user_notadmin)
		assert_difference 'Installation.count', 1 do
			get :create, id: @installation, installation: {  name: "PMIG", version: "1.1", os: "linux", source_link: "pimg.com", user_id: @user_admin.id}
		end
		assert_equal 302, response.status
    assert_response :redirect
		assert_redirected_to installations_path
		assert_not flash.empty?
		assert_equal  "New Installation Saved!!!", flash[:success]
	end

	#Logged in user, not admin, not owner
	#######################################
		
	test "logged in, not admin, not owner should not show" do
		log_in_as(@user_notadmin)
		get :show, id: @installation.id
		assert_equal 302, response.status
    assert_response :redirect
		assert_redirected_to root_path
		assert_not flash.empty?
		assert_equal  "User can see only his installations!", flash[:danger]
	end
	
	test "logged in, not admin, not owner should not edit" do
		log_in_as(@user_notadmin)
    get :edit, id: @installation
		assert_equal 302, response.status
    assert_response :redirect
		assert_redirected_to root_path
		#assert_not flash.empty?
		#assert_equal  "Please log in.", flash[:danger]
	end
	
	test "logged in, not admin, not owner should not update" do
		log_in_as(@user_notadmin)
    patch :update, id: @installation, installation: {  name: "PMIG", version: "1.1", os: "linux", source_link: "pimg.com", user_id: @user_admin.id}
		assert_equal 302, response.status
    assert_response :redirect
		assert_redirected_to root_path
		#assert_not flash.empty?
		#assert_equal  "Please log in.", flash[:danger]
	end
	
	test "logged in, not admin, not owner should not destroy" do
		log_in_as(@user_notadmin)	
		assert_no_difference 'Installation.count' do
			delete :destroy, id: @installation
		end
		assert_equal 302, response.status
    assert_response :redirect
		assert_redirected_to root_path
		#assert_not flash.empty?
		#assert_equal  "Please log in.", flash[:danger]
	end
	
	
	#Logged in user, not admin, owner
	#######################################
		
	test "logged in, not admin, owner should show" do
		log_in_as(@user_notadmin)
		get :show, id: @installation_notadmin
		assert_equal 200, response.status
    assert_response :success
		assert_select 'h1', text: "Installation of: " + String(@installation_notadmin.name), count: 1
	end
	
	test "logged in, not admin, owner should not edit" do
		log_in_as(@user_notadmin)
    get :edit, id: @installation_notadmin
		assert_equal 302, response.status
    assert_response :redirect
		assert_redirected_to root_path
		#assert_not flash.empty?
		#assert_equal  "Please log in.", flash[:danger]
	end
	
	test "logged in, not admin, owner should not update" do
		log_in_as(@user_notadmin)
    patch :update, id: @installation_notadmin, installation: {  name: "PMIG", version: "1.1", os: "linux", source_link: "pimg.com", user_id: @user_admin.id}
		assert_equal 302, response.status
    assert_response :redirect
		assert_redirected_to root_path
		#assert_not flash.empty?
		#assert_equal  "Please log in.", flash[:danger]
	end
	
	test "logged in, not admin, owner should not destroy" do
		log_in_as(@user_notadmin)	
		assert_no_difference 'Installation.count' do
			delete :destroy, id: @installation_notadmin
		end
		assert_equal 302, response.status
    assert_response :redirect
		assert_redirected_to root_path
		#assert_not flash.empty?
		#assert_equal  "Please log in.", flash[:danger]
	end
	
	
	#Logged in user, admin
	#######################################
	
	test "logged in, admin should index" do
		log_in_as(@user_admin)
		get :index
		assert_equal 200, response.status
    assert_response :success
		assert_select 'h1', text: "All Installations", count: 1
	end

	test "logged in, admin should new" do
		log_in_as(@user_admin)
		get :new
		assert_equal 200, response.status
    assert_response :success
		assert_select 'h1', text: "New Installation", count: 1
	end
	
	test "logged in, admin should create" do
		log_in_as(@user_admin)
		assert_difference 'Installation.count', 1 do
			get :create, id: @installation, installation: { name: "PMIG", version: "1.1", os: "linux", source_link: "pimg.com", user_id: @user_admin.id}
		end
		assert_equal 302, response.status
    assert_response :redirect
		assert_redirected_to installations_path		
		assert_not flash.empty?
		assert_equal  "New Installation Saved!!!", flash[:success]
	end
		
	test "logged in, admin, should show" do
		log_in_as(@user_admin)
		get :show, id: @installation.id
		assert_equal 200, response.status
    assert_response :success
		assert_select 'h1', text: "Installation of: " + String(@installation.name), count: 1
	end
	
	test "logged in, admin, should edit" do
		log_in_as(@user_admin)
    get :edit, id: @installation
		assert_equal 200, response.status
    assert_response :success
		assert_select 'h1', text: "Edit Installation", count: 1
	end
	
	test "logged in, admin should update" do
		log_in_as(@user_admin)
    patch :update, id: @installation, installation: {  name: "PMIG", version: "1.1", os: "linux", source_link: "pimg.com", user_id: @user_admin.id}
		assert_equal 302, response.status
    assert_response :redirect
		assert_redirected_to installations_path
		assert_equal  "You know what you're doing!", flash[:success]		
	end
	
	test "logged in, admin should destroy" do
		log_in_as(@user_admin)	
		assert_difference 'Installation.count', -1 do
			delete :destroy, id: @installation
		end
		assert_equal 302, response.status
    assert_response :redirect
		assert_redirected_to installations_path
		assert_equal  "Installation deleted", flash[:success]				
	end
	
	
	
	test "should edit for admin user version only" do		
		log_in_as(@user_admin)
		@installation = Installation.first
		assert_match @installation.name, "GIMP"
		assert_match @installation.version, "1.1"
		assert_match @installation.os, "linux"
		assert_match @installation.source_link, "gimp.com"
		assert_no_difference 'Installation.count' do
			patch :update, id: @installation, installation: {version: "1.2"}
		end
		assert_redirected_to installations_path
		@installation2 = Installation.first
		assert_match @installation2.name, "GIMP"
		assert_match @installation2.version, "1.2"
		assert_match @installation2.os, "linux"
		assert_match @installation2.source_link, "gimp.com"
	end
	
	test "should edit for admin user os only" do		
		log_in_as(@user_admin)
		@installation = Installation.first
		assert_match @installation.name, "GIMP"
		assert_match @installation.version, "1.1"
		assert_match @installation.os, "linux"
		assert_match @installation.source_link, "gimp.com"
		assert_no_difference 'Installation.count' do
			patch :update, id: @installation, installation: {os: "xos"}
		end
		assert_redirected_to installations_path
		@installation2 = Installation.first
		assert_match @installation2.name, "GIMP"
		assert_match @installation2.version, "1.1"
		assert_match @installation2.os, "xos"
		assert_match @installation2.source_link, "gimp.com"
	end
	
	test "should edit for admin user source link only" do		
		log_in_as(@user_admin)
		@installation = Installation.first
		assert_match @installation.name, "GIMP"
		assert_match @installation.version, "1.1"
		assert_match @installation.os, "linux"
		assert_match @installation.source_link, "gimp.com"
		assert_no_difference 'Installation.count' do
			patch :update, id: @installation, installation: {source_link: "pmig.com"}
		end
		assert_redirected_to installations_path
		@installation2 = Installation.first
		assert_match @installation2.name, "GIMP"
		assert_match @installation2.version, "1.1"
		assert_match @installation2.os, "linux"
		assert_match @installation2.source_link, "pmig.com"
	end
	
	test "should edit for admin user without user change" do		
		log_in_as(@user_admin)
		@installation = Installation.first
		assert_equal @installation.user_id, @user.id
		assert_no_difference 'Installation.count' do
			patch :update, id: @installation, installation: {user_id: @user_admin.id}
		end
		assert_redirected_to installations_path
		@installation2 = Installation.first
		assert_equal @installation.user_id, @user.id
		assert_not_equal @installation.user_id, @user_admin.id		
	end
	
	test "should not edit added_by for not admin user" do		
		log_in_as(@user_notadmin)
		@installation = Installation.first
		assert_equal @installation.user_id, @user.id
		assert_no_difference 'Installation.count' do
			patch :update, id: @installation, installation: {user_id: @user_admin.id}
		end
		assert_redirected_to root_path
		@installation2 = Installation.first
		assert_equal @installation2.user_id, @user.id
	end
		
end
