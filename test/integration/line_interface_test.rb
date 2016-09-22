require 'test_helper'

class LinesInterfaceTest < ActionDispatch::IntegrationTest
  def setup
		@line = lines(:first)
		@user_admin = users(:michael)
		@user_notadmin = users(:archer)
	end
	
	test "line interface for admin user" do
		log_in_as(@user_admin)
		get root_path
		assert_select 'div.pagination'
		assert_select 'input[type=submit]'
		get lines_path
		@amount = Line.count
		assert_match String(Line.count) + ' line'.pluralize(@amount), response.body
		assert_select 'a', text: 'delete', count: @amount
		# Invalid submission
		assert_no_difference 'Line.count' do
			post lines_path, params: {'line' => { 'content' => "", 'index' => 3 }}
		end
		assert_select 'div#error_explanation'
		# Valid submission
		assert_difference 'Line.count', 1 do
			post lines_path, params: {'line' => { 'content' => "odus teg-tpa etadpu", 'index' => 23 }}
		end
		#Assert_redirected_to instalation_path
		follow_redirect!
		assert_match "odus teg-tpa etadpu", response.body
		assert_select 'a', text: 'delete', count: @amount + 1
		#Delete a post.
		first_line = Line.paginate(page: 1).first
		assert_difference 'Line.count', -1 do
			delete line_path(first_line)
		end
		get lines_path
		assert_select 'a', text: 'delete', count: @amount
	end
	
	test "line interface for not admin user" do
		log_in_as(@user_notadmin)
		get root_path
		assert_select 'div.pagination'
		assert_select 'input[type=submit]'
		get lines_path
		@amount = Line.count
		assert_match String(@amount) + ' line'.pluralize(@amount), response.body
		assert_select 'a', text: 'delete', count: 0
		# Valid submission
		assert_no_difference 'Line.count' do
			post lines_path, params: {'line' => { 'content' => "odus teg-tpa etadpu", 'index' => 1 }}
		end
		#Assert_redirected_to instalation_path
		follow_redirect!
		get lines_path
		#assert_match "odus teg-tpa etadpu", response.body
		assert_match String(@amount) + ' line'.pluralize(@amount), response.body
		assert_select 'a', text: 'delete', count: 0
		#Delete a post.
		first_line = Line.paginate(page: 1).first
		assert_no_difference 'Line.count' do
			delete line_path(first_line)
		end
		get lines_path
		assert_match String(@amount) + ' line'.pluralize(@amount), response.body
		assert_select 'a', text: 'delete', count: 0
	end
	
	
	test "line sidebar count" do
		log_in_as(@user_admin)
		get lines_path
		assert_match "#{Line.count} lines", response.body
		first_line = Line.paginate(page: 1).first
		while first_line
			delete line_path(first_line)
			first_line = Line.paginate(page: 1).first
		end
		get lines_path
		assert_match "0 lines", response.body
		Line.create!(content: "gimp1 line", index: 56)
		get lines_path
		assert_match "1 line", response.body
		Line.create!(content: "gimp2 line", index: 57)
		get lines_path
		assert_match "2 lines", response.body
	end
	
	
#	test "line sidebar count2" do
#		log_in_as(@user_admin)
#		assert_match "gfd", response.body
#
#		get lines_path
#		assert_match "#{Line.count} lines", response.body
#		first_line = Line.paginate(page: 1).first
#		while first_line
#			delete line_path(first_line)
#			first_line = Line.paginate(page: 1).first
#		end
#		get lines_path
#		assert_match "0 lines", response.body
#		Line.create!(content: "gimp1 line", index: 56)
#		get lines_path
#		assert_match "1 line", response.body
#		Line.create!(content: "gimp2 line", index: 57)
#		get lines_path
#		assert_match "2 lines", response.body
#	end
	
#	test "open show as admin2" do
#		log_in_as(@user_admin)
#		get line_path(@line)
#		#get lines_path
#		#assert_template 'lines/show'
#		#assert_select 'a.delete'
#		#assert_select 'a', text: 'delete', response.body
#		assert_match "detete", response.body
#	end
end
