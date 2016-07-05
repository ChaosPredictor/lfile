require 'test_helper'

class InstalationsInterfaceTest < ActionDispatch::IntegrationTest

	
	def setup
		@line    				  = lines(:first)
		@lines            = Line.all
		@number_of_lines  = Line.count		
		@instalation      = instalations(:gimp)
		@user_admin       = users(:michael)
		@user_notadmin    = users(:archer)		
	end
	
	#SHOW
#	##################################
#	test "show as admin" do
#		log_in_as(@user_admin)
#		get line_path(@instalation)
#		assert_match 'Show Line ' + String(@line.index) , response.body
#		assert_select 'h1#index', text: 'Index: ' + String(@line.index), count: 1		
#		assert_select 'div#content', text: 'Content: ' + @line.content, count: 1		
#		assert_select 'a.edit', text: 'edit', count: 1
#		assert_select 'a.delete', text: 'delete', count: 1
#	end
	
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

#	#INDEX
#	#######################################
#	
#	
#	test "index as admin" do
#		log_in_as(@user_admin)
#		get lines_path
#		assert_select 'h1', text: 'All Lines', count: 1	
#		assert_match String(@number_of_lines) + ' lines', response.body
#		assert_select 'a.edit', text: "edit", count: @number_of_lines	
#		assert_select 'a.delete', text: "delete", count: @number_of_lines
#		@lines.each do |line|
#			assert_match line.content, response.body
#			assert_match String(line.index), response.body			
#		end
#	end
#	
#	test "index as not admin" do
#		log_in_as(@user_notadmin)
#		get lines_path
#		assert_select 'h1', text: 'All Lines', count: 1	
#		assert_match String(@number_of_lines) + ' lines', response.body
#		assert_select 'a.edit', text: "edit", count: 0	
#		assert_select 'a.delete', text: "delete", count: 0
#		@lines.each do |line|
#			assert_match line.content, response.body
#			assert_match String(line.index), response.body			
#		end	
#	end
#
#	test "index as not loged in" do
#		get lines_path
#		assert_redirected_to login_path
#		assert_select 'h1', text: 'All Lines', count: 0
#		assert_no_match String(@number_of_lines) + ' lines', response.body
#		assert_select 'a.edit', text: "edit", count: 0	
#		assert_select 'a.delete', text: "delete", count: 0
#		@lines.each do |line|
#			assert_no_match line.content, response.body
#			assert_no_match String(line.index), response.body			
#		end		
#	end
	
end