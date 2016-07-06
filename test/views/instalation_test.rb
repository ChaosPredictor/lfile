require 'test_helper'

class InstalationsInterfaceTest < ActionDispatch::IntegrationTest

	
	def setup
		@instalation             = Instalation.first
		@instalations            = Instalation.all
		@number_of_instalation   = Instalation.count
		params                   = 1
		@line                    = Line.first
		@lines                   = @instalation.lines.paginate(page: params[0])
		@number_of_lines         = @lines.count	
		@user_admin              = users(:michael)
		@user_notadmin           = users(:archer)		
	end
	
	#SHOW
	##################################
	test "show as admin" do
		log_in_as(@user_admin)
		@instalation.addline(@line, 1)
		assert @instalation.hasline?(@line)
		get instalation_path(@instalation) # SAME AS get :show, id: @instalation
		assert_match 'Instalation of: ' + String(@instalation.name) , response.body
		assert_select 'h1', text: 'Instalation of: ' + @instalation.name, count: 1		
		assert_select 'h2 div#version', text: 'Version: ' + @instalation.version, count: 1		
		assert_select 'h2 div#os', text: 'Operation System: ' + @instalation.os, count: 1	
		assert_select 'a.edit', text: 'edit', count: 1
		assert_select 'a.delete', text: 'delete', count: 1
		#assert_match String(@number_of_lines) + ' line'.pluralize(@amount) + "i", response.body
		#assert_match 'ttt'+String(@instalation.id), response.body
	end
	
	
#	test "show as notadmin" do
#		log_in_as(@user_notadmin)
#		get line_path(@line)
#		assert_select 'h1#index', text: 'Index: ' + String(@line.index), count: 1		
#		assert_select 'div#content', text: 'Content: ' + @line.content, count: 1		
#		assert_select 'a.edit', text: 'edit', count: 0
#		assert_select 'a.delete', text: 'delete', count: 0
#	end
#
#	test "show as not loged" do
#		get line_path(@line)
#		assert_redirected_to login_path
#		assert_select 'h1#index', text: 'Index: ' + String(@line.index), count: 0
#		assert_select 'div#content', text: 'Content: ' + @line.content, count: 0		
#		assert_select 'a.edit', text: 'edit', count: 0
#		assert_select 'a.delete', text: 'delete', count: 0
#	end
#	
#	
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
		assert_redirected_to login_path
		assert_select 'h1', text: 'All Instalations', count: 0
		assert_no_match String(@number_of_instalations) + ' instalations', response.body
		assert_select 'a.edit', text: "edit", count: 0	
		assert_select 'a.delete', text: "delete", count: 0
		@instalations.each do |instalation|
			assert_no_match instalation.name, response.body		
		end
	end
	
end