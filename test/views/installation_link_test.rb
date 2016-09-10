require 'test_helper'

class InstallationsLinksInterfaceTest < ActionDispatch::IntegrationTest

	
	def setup
		@installation             = Installation.first
		@installations            = Installation.all
		@installation2            = Installation.all[1]
		@number_of_installation   = Installation.count
		@line                     = Line.first
		@line1                    = lines(:l1)
		@line2                    = lines(:l2)
		@line3                    = lines(:l3)
		@line4                    = lines(:l4)
		@lines                    = @installation.hasline.paginate(page: 1)
		@number_of_lines          = @lines.count	
		@user_admin               = users(:michael)
		@user_notadmin            = users(:archer)
		@user                     = User.first
		@installation.update(user_id: @user.id)
	end
	
	#INDEX
	#######################################
		
	test "index as admin" do
		log_in_as(@user_admin)
		get installations_path
		assert_select "a[href=?]", instanew_path, text: "Create New Installation", count: 1
		@installations.each do |installation|
			#assert_match installation.name, response.body
			assert_select "a[href=?]", "/installations/#{installation.id}/edit", text: "edit", count: 1
			assert_select "a[href=?][data-method=delete]", "/installations/#{installation.id}", text: "delete", count: 1
			assert_select "a[href=?]", "/installations/#{installation.id}", text: installation.name, count: 1
		end
	end
	
	test "index as not admin" do
		log_in_as(@user_notadmin)
		get installations_path
		assert_select "a[href=?]", instanew_path, text: "Create New Installation", count: 1
		@installations.each do |installation|
			#assert_match installation.name, response.body
			assert_select "a[href=?]", "/installations/#{installation.id}/edit", text: "edit", count: 0
			assert_select "a[href=?][data-method=delete]", "/installations/#{installation.id}", text: "delete", count: 0
			assert_select "a[href=?]", "/installations/#{installation.id}", text: installation.name, count: 1
		end
	end
	
	test "index as not logged in" do
		get installations_path
		assert_select "a[href=?]", instanew_path, text: "Create New Installation", count: 0
		@installations.each do |installation|
			#assert_match installation.name, response.body
			assert_select "a[href=?]", "/installations/#{installation.id}/edit", text: "edit", count: 0
			assert_select "a[href=?][data-method=delete]", "/installations/#{installation.id}", text: "delete", count: 0
			assert_select "a[href=?]", "/installations/#{installation.id}", text: installation.name, count: 0
		end
	end
	
	
	
	#SHOW
	#######################################
		
	test "show as admin" do
		log_in_as(@user_admin)
		get installation_path(@installation)
		assert_select "input[type=submit][name=commit]", count: 1
		assert_select "select[id=step_line_id]", count: 1
	end
	
	test "show as not admin" do
		log_in_as(@user_notadmin)
		get installation_path(@installation)
		assert_select "input[type=submit][name=commit]", count: 0
		assert_select "select[id=step_line_id]", count: 0
	end
	
	test "show as not user" do
		get installation_path(@installation)
		assert_select "input[type=submit][name=commit]", count: 0
		assert_select "select[id=step_line_id]", count: 0
	end
	
	
#	test "show as not admin" do
#		log_in_as(@user_notadmin)
#		get installations_path
#		assert_select "a[href=?]", instanew_path, text: "Create New Installation", count: 1
#		@installations.each do |installation|
#			#assert_match installation.name, response.body
#			assert_select "a[href=?]", "/installations/#{installation.id}/edit", text: "edit", count: 0
#			assert_select "a[href=?][data-method=delete]", "/installations/#{installation.id}", text: "delete", count: 0
#			assert_select "a[href=?]", "/installations/#{installation.id}", text: installation.name, count: 1
#		end
#	end
	
	
	
end