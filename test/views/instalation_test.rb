require 'test_helper'

class InstallationsInterfaceTest < ActionDispatch::IntegrationTest

	
	def setup
		@installation             = Installation.first
		@installations            = Installation.all
		@installation2            = Installation.all[1]
		@number_of_installation   = Installation.count
		@line                    = Line.first
		@line1                   = lines(:l1)
		@line2                   = lines(:l2)
		@line3                   = lines(:l3)
		@line4                   = lines(:l4)
		@lines                   = @installation.hasline.paginate(page: 1)
		@number_of_lines         = @lines.count	
		@user_admin              = users(:michael)
		@user_notadmin           = users(:archer)
		@user                    = User.first
	end
	
	#SHOW
	##################################
	test "show as admin" do
		log_in_as(@user_admin)
		@installation.addline(@line1, 0)
		@installation.addline(@line2, 1)
		@installation.addline(@line3, 2)
		@installation.addline(@line4, 3)
		assert @installation.line?(@line)
		@steps = Step.all.select{|step| step[:installation_id] == @installation.id }
		number_of_steps = @steps.count
		@installation.user_id = @user.id
		@installation.save
		get installation_path(@installation) # SAME AS get :show, id: @installation
		assert_match 'Installation of: ' + String(@installation.name) , response.body
		assert_select 'h1', text: 'Installation of: ' + @installation.name, count: 1		
		assert_select 'h2 div#version', text: 'Version: ' + @installation.version, count: 1		
		assert_select 'h2 div#os', text: 'Operation System: ' + @installation.os, count: 1	
		assert_select 'h2 div#source_link', text: 'Source link: ' + @installation.source_link, count: 1	
		assert_select 'h2 div#added_by', text: 'Added by: ' + @user.name, count: 1	
		assert_select 'a.edit', text: 'edit', count: 1
		assert_select 'a.delete', text: 'delete', count: 1
		assert_select 'a.remove', text: 'remove', count: number_of_steps
		(0..number_of_steps-1).each do |t|			
			assert_select 'div.order' + String(t), text: String(@steps[t][:order]), count: 1
			assert_select 'div.id' + String(t), text: String(@steps[t][:id]), count: 1
			assert_select 'div.line_id' + String(t), text: String(Line.find(@steps[t][:line_id])[:id]), count: 1
			assert_select 'div.line_content' + String(t), text: String(Line.find(@steps[t][:line_id])[:content]), count: 1
			assert_select 'div.delete_link' + String(t), text: 'remove', count: 1
		end
	end
	
	test "show as not admin" do
		log_in_as(@user_notadmin)
		@installation.addline(@line1, 0)
		@installation.addline(@line2, 1)
		@installation.addline(@line3, 2)
		@installation.addline(@line4, 3)
		assert @installation.line?(@line)
		@steps = Step.all.select{|step| step[:installation_id] == @installation.id }
		number_of_steps = @steps.count
		@installation.user_id = @user.id
		@installation.save
		get installation_path(@installation) # SAME AS get :show, id: @installation
		#TODO should be changed
#		assert_match 'Installation of: ' + String(@installation.name) , response.body
#		assert_select 'h1', text: 'Installation of: ' + @installation.name, count: 1		
#		assert_select 'h2 div#version', text: 'Version: ' + @installation.version, count: 1		
#		assert_select 'h2 div#os', text: 'Operation System: ' + @installation.os, count: 1	
#		assert_select 'h2 div#source_link', text: 'Source link: ' + @installation.source_link, count: 1	
#		assert_select 'a.edit', text: 'edit', count: 0
#		assert_select 'a.delete', text: 'delete', count: 0
#		assert_select 'a.remove', text: 'remove', count: 0
#		(0..number_of_steps-1).each do |t|			
#			assert_select 'div.order' + String(t), text: String(@steps[t][:order]), count: 1
#			assert_select 'div.id' + String(t), text: String(@steps[t][:id]), count: 0
#			assert_select 'div.line_id' + String(t), text: String(Line.find(@steps[t][:line_id])[:id]), count: 0
#			assert_select 'div.line_content' + String(t), text: String(Line.find(@steps[t][:line_id])[:content]), count: 1
#			assert_select 'div.delete_link' + String(t), text: 'remove', count: 0
#		end
	end	
	
	test "show as not loged in" do
		@installation.addline(@line1, 0)
		@installation.addline(@line2, 1)
		@installation.addline(@line3, 2)
		@installation.addline(@line4, 3)
		assert @installation.line?(@line)
		@steps = Step.all.select{|step| step[:installation_id] == @installation.id }
		number_of_steps = @steps.count
		get installation_path(@installation) # SAME AS get :show, id: @installation
		assert_redirected_to login_path
		assert_no_match 'Installation of: ' + String(@installation.name) , response.body
		#TODO maybe it should be chnaged
		assert_select 'h1', text: 'Installation of: ' + @installation.name, count: 0		
		assert_select 'h2 div#version', text: 'Version: ' + @installation.version, count: 0		
		assert_select 'h2 div#os', text: 'Operation System: ' + @installation.os, count: 0	
		assert_select 'h2 div#source_link', text: 'Source link: ' + @installation.source_link, count: 0
		assert_select 'a.edit', text: 'edit', count: 0
		assert_select 'a.delete', text: 'delete', count: 0
		assert_select 'a.remove', text: 'remove', count: 0
		(0..number_of_steps-1).each do |t|			
			assert_select 'div.order' + String(t), text: String(@steps[t][:order]), count: 0
			assert_select 'div.id' + String(t), text: String(@steps[t][:id]), count: 0
			assert_select 'div.line_id' + String(t), text: String(Line.find(@steps[t][:line_id])[:id]), count: 0
			assert_select 'div.line_content' + String(t), text: String(Line.find(@steps[t][:line_id])[:content]), count: 0
			assert_select 'div.delete_link' + String(t), text: 'remove', count: 0
		end
	end
	

	#EDIT
	###################################
	test "edit as admin" do
		log_in_as(@user_admin)
		get edit_installation_path(@installation)
		assert_select 'h1', text: 'Edit Installation', count: 1	
		assert_match 'Edit Installation ' + String(@installation.id) , response.body
		assert_select 'input#installation_name', value: @installation.name, count: 1		
		assert_select 'input#installation_version', value: @installation.version, count: 1		
		assert_select 'input#installation_os', value: @installation.os, count: 1		
		assert_select 'input#installation_source_link', value: @installation.source_link, count: 1		
		assert_select 'input.btn', type: "submit", value: "Save changes", count: 1		
	end
	
	test "edit as notadmin" do
		log_in_as(@user_notadmin)
		get edit_installation_path(@installation)
		assert_redirected_to root_path
		assert_select 'h1', text: 'Edit Installation', count: 0
		assert_no_match 'Edit Installation ' + String(@installation.id) , response.body
		assert_select 'input#installation_name', value: @installation.name, count: 0	
		assert_select 'input#installation_version', value: @installation.version, count: 0		
		assert_select 'input#installation_os', value: @installation.os, count: 0
		assert_select 'input#installation_source_link', value: @installation.source_link, count: 0		
		assert_select 'input.btn', type: "submit", value: "Save changes", count: 0	
	end

#	test "edit as not loged in" do
#		get edit_installation_path(@installation)
#		assert_redirected_to login_path
#		assert_select 'h1', text: 'Edit Installation', count: 0
#		assert_no_match 'Edit Installation ' + String(@installation.id) , response.body
#		assert_select 'input#installation_name', value: @installation.name, count: 0	
#		assert_select 'input#installation_version', value: @installation.version, count: 0		
#		assert_select 'input#installation_os', value: @installation.os, count: 0
#		assert_select 'input#installation_source_link', value: @installation.source_link, count: 0				
#		assert_select 'input.btn', type: "submit", value: "Save changes", count: 0	
#	end

	#INDEX
	#######################################
	
	
	test "index as admin" do
		log_in_as(@user_admin)
		get installations_path
		assert_select 'h1', text: 'All Installations', count: 1	
		assert_match String(@number_of_installations) + ' installations', response.body
		assert_select 'a.edit', text: "edit", count: @number_of_installations	
		assert_select 'a.delete', text: "delete", count: @number_of_installations
		@installations.each do |installation|
			assert_match installation.name, response.body		
		end
	end
	
	test "index as not admin" do
		log_in_as(@user_notadmin)
		get installations_path
		assert_select 'h1', text: 'All Installations', count: 1	
		assert_match String(@number_of_installations) + ' installations', response.body
		assert_select 'a.edit', text: "edit", count: 0	
		assert_select 'a.delete', text: "delete", count: 0
		@installations.each do |installation|
			assert_match installation.name, response.body		
		end
	end

	test "index as not loged in" do
		get installations_path		
		assert_select 'h1', text: 'All Installations', count: 1
		assert_match String(@number_of_installations) + ' installations', response.body
		assert_select 'a.edit', text: "edit", count: 0	
		assert_select 'a.delete', text: "delete", count: 0
		@installations.each do |installation|
			assert_match installation.name, response.body		
		end
	end
	
	test "with and without source link" do
		log_in_as(@user_admin)
		@installation.user_id = @user.id
		@installation.save
		get installation_path(@installation) # SAME AS get :show, id: @installation
		assert_select 'h1', text: 'Installation of: ' + @installation.name, count: 1		
		assert_select 'h2 div#source_link', text: 'Source link: ' + @installation.source_link, count: 1
		@installation.source_link = nil
		@installation.save
		get installation_path(@installation) # SAME AS get :show, id: @installation
		assert_select 'h1', text: 'Installation of: ' + @installation.name, count: 1		
		assert_select 'h2 div#source_link', text: 'No link attached', count: 1	
	end
	
end