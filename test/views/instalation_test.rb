require 'test_helper'

class InstalationsInterfaceTest < ActionDispatch::IntegrationTest

	
	def setup
		@instalation             = Instalation.first
		@instalations            = Instalation.all
		@instalation2            = Instalation.all[1]
		@number_of_instalation   = Instalation.count
		@line                    = Line.first
		@line1                   = lines(:l1)
		@line2                   = lines(:l2)
		@line3                   = lines(:l3)
		@line4                   = lines(:l4)
		@lines                   = @instalation.hasline.paginate(page: 1)
		@number_of_lines         = @lines.count	
		@user_admin              = users(:michael)
		@user_notadmin           = users(:archer)		
	end
	
	#SHOW
	##################################
	test "show as admin" do
		log_in_as(@user_admin)
		@instalation.addline(@line1, 0)
		@instalation.addline(@line2, 1)
		@instalation.addline(@line3, 2)
		@instalation.addline(@line4, 3)
		assert @instalation.line?(@line)
		@steps = Step.all.select{|step| step[:instalation_id] == @instalation.id }
		number_of_steps = @steps.count
		get instalation_path(@instalation) # SAME AS get :show, id: @instalation
		assert_match 'Instalation of: ' + String(@instalation.name) , response.body
		assert_select 'h1', text: 'Instalation of: ' + @instalation.name, count: 1		
		assert_select 'h2 div#version', text: 'Version: ' + @instalation.version, count: 1		
		assert_select 'h2 div#os', text: 'Operation System: ' + @instalation.os, count: 1	
		assert_select 'h2 div#source_link', text: 'Source link: ' + @instalation.source_link, count: 1	
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
		@instalation.addline(@line1, 0)
		@instalation.addline(@line2, 1)
		@instalation.addline(@line3, 2)
		@instalation.addline(@line4, 3)
		assert @instalation.line?(@line)
		@steps = Step.all.select{|step| step[:instalation_id] == @instalation.id }
		number_of_steps = @steps.count
		get instalation_path(@instalation) # SAME AS get :show, id: @instalation
		assert_match 'Instalation of: ' + String(@instalation.name) , response.body
		assert_select 'h1', text: 'Instalation of: ' + @instalation.name, count: 1		
		assert_select 'h2 div#version', text: 'Version: ' + @instalation.version, count: 1		
		assert_select 'h2 div#os', text: 'Operation System: ' + @instalation.os, count: 1	
		assert_select 'h2 div#source_link', text: 'Source link: ' + @instalation.source_link, count: 1	
		assert_select 'a.edit', text: 'edit', count: 0
		assert_select 'a.delete', text: 'delete', count: 0
		assert_select 'a.remove', text: 'remove', count: 0
		(0..number_of_steps-1).each do |t|			
			assert_select 'div.order' + String(t), text: String(@steps[t][:order]), count: 1
			assert_select 'div.id' + String(t), text: String(@steps[t][:id]), count: 0
			assert_select 'div.line_id' + String(t), text: String(Line.find(@steps[t][:line_id])[:id]), count: 0
			assert_select 'div.line_content' + String(t), text: String(Line.find(@steps[t][:line_id])[:content]), count: 1
			assert_select 'div.delete_link' + String(t), text: 'remove', count: 0
		end
	end	
	
	test "show as not loged in" do
		@instalation.addline(@line1, 0)
		@instalation.addline(@line2, 1)
		@instalation.addline(@line3, 2)
		@instalation.addline(@line4, 3)
		assert @instalation.line?(@line)
		@steps = Step.all.select{|step| step[:instalation_id] == @instalation.id }
		number_of_steps = @steps.count
		get instalation_path(@instalation) # SAME AS get :show, id: @instalation
		assert_redirected_to login_path
		assert_no_match 'Instalation of: ' + String(@instalation.name) , response.body
		#TODO maybe it should be chnaged
		assert_select 'h1', text: 'Instalation of: ' + @instalation.name, count: 0		
		assert_select 'h2 div#version', text: 'Version: ' + @instalation.version, count: 0		
		assert_select 'h2 div#os', text: 'Operation System: ' + @instalation.os, count: 0	
		assert_select 'h2 div#source_link', text: 'Source link: ' + @instalation.source_link, count: 0
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
		get edit_instalation_path(@instalation)
		assert_select 'h1', text: 'Edit Instalation', count: 1	
		assert_match 'Edit Instalation ' + String(@instalation.id) , response.body
		assert_select 'input#instalation_name', value: @instalation.name, count: 1		
		assert_select 'input#instalation_version', value: @instalation.version, count: 1		
		assert_select 'input#instalation_os', value: @instalation.os, count: 1		
		assert_select 'input#instalation_source_link', value: @instalation.source_link, count: 1		
		assert_select 'input.btn', type: "submit", value: "Save changes", count: 1		
	end
	
	test "edit as notadmin" do
		log_in_as(@user_notadmin)
		get edit_instalation_path(@instalation)
		assert_redirected_to root_path
		assert_select 'h1', text: 'Edit Instalation', count: 0
		assert_no_match 'Edit Instalation ' + String(@instalation.id) , response.body
		assert_select 'input#instalation_name', value: @instalation.name, count: 0	
		assert_select 'input#instalation_version', value: @instalation.version, count: 0		
		assert_select 'input#instalation_os', value: @instalation.os, count: 0
		assert_select 'input#instalation_source_link', value: @instalation.source_link, count: 0		
		assert_select 'input.btn', type: "submit", value: "Save changes", count: 0	
	end

	test "edit as not loged in" do
		get edit_instalation_path(@instalation)
		assert_redirected_to login_path
		assert_select 'h1', text: 'Edit Instalation', count: 0
		assert_no_match 'Edit Instalation ' + String(@instalation.id) , response.body
		assert_select 'input#instalation_name', value: @instalation.name, count: 0	
		assert_select 'input#instalation_version', value: @instalation.version, count: 0		
		assert_select 'input#instalation_os', value: @instalation.os, count: 0
		assert_select 'input#instalation_source_link', value: @instalation.source_link, count: 0				
		assert_select 'input.btn', type: "submit", value: "Save changes", count: 0	
	end

	#INDEX
	#######################################
	
	
	test "index as admin" do
		log_in_as(@user_admin)
		get instalations_path
		assert_select 'h1', text: 'All Instalations', count: 1	
		assert_match String(@number_of_instalations) + ' instalations', response.body
		assert_select 'a.edit', text: "edit", count: @number_of_instalations	
		assert_select 'a.delete', text: "delete", count: @number_of_instalations
		@instalations.each do |instalation|
			assert_match instalation.name, response.body		
		end
	end
	
	test "index as not admin" do
		log_in_as(@user_notadmin)
		get instalations_path
		assert_select 'h1', text: 'All Instalations', count: 1	
		assert_match String(@number_of_instalations) + ' instalations', response.body
		assert_select 'a.edit', text: "edit", count: 0	
		assert_select 'a.delete', text: "delete", count: 0
		@instalations.each do |instalation|
			assert_match instalation.name, response.body		
		end
	end

	test "index as not loged in" do
		get instalations_path		
		assert_select 'h1', text: 'All Instalations', count: 1
		assert_match String(@number_of_instalations) + ' instalations', response.body
		assert_select 'a.edit', text: "edit", count: 0	
		assert_select 'a.delete', text: "delete", count: 0
		@instalations.each do |instalation|
			assert_match instalation.name, response.body		
		end
	end
	
	test "with and without source link" do
		log_in_as(@user_admin)
		get instalation_path(@instalation) # SAME AS get :show, id: @instalation
		assert_select 'h1', text: 'Instalation of: ' + @instalation.name, count: 1		
		assert_select 'h2 div#source_link', text: 'Source link: ' + @instalation.source_link, count: 1
		@instalation.source_link = nil
		@instalation.save
		get instalation_path(@instalation) # SAME AS get :show, id: @instalation
		assert_select 'h1', text: 'Instalation of: ' + @instalation.name, count: 1		
		assert_select 'h2 div#source_link', text: 'No link attached', count: 1	
	end
	
end