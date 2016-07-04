require 'test_helper'

class LinesControllerTest < ActionController::TestCase
	def setup
		@line    				  = lines(:first)
		@user_admin       = users(:michael)
		@user_notadmin    = users(:archer)		
	end
	
	test "should create when admin" do
		log_in_as(@user_admin)
		assert_difference 'Line.count', 1 do
			post :create, line: { content: "Lorem", index: 31 }
		end
		assert_redirected_to lines_path
	end

	test "should not create when not admin user" do
		log_in_as(@user_notadmin)
		assert_no_difference 'Line.count' do
			post :create, line: { content: "Lorem", index: 31 }
		end
		#TODO assert_equal flash[:error], "Only Admin can add line"
		assert_redirected_to root_path
	end

	test "should not create when not logged in" do
		assert_no_difference 'Line.count' do
			post :create, line: { content: "Lorem", index: 31 }
		end
		assert_redirected_to login_url
	end

	test "should destroy when admin user" do		
		log_in_as(@user_admin)
		assert_difference 'Line.count', -1 do
			delete :destroy, id: @line	
		end
		assert_redirected_to lines_path
	end

	test "should not destroy when not admin user" do
		log_in_as(@user_notadmin)
		assert_no_difference 'Line.count' do
			delete :destroy, id: @line	
		end
		assert_redirected_to root_path
	end

	test "should not destroy when not logged in" do
		assert_no_difference 'Line.count' do
			delete :destroy, id: @line	
		end
		assert_redirected_to login_path
	end

	test "should edit when admin user" do		
		log_in_as(@user_admin)
		line_id = @line.id
		new_content = "this line was edit"
		assert_no_difference 'Line.count' do
			patch :update, id: @line, line: {content: new_content, 
																			index: 41}
		end
		assert_redirected_to lines_path
		@LineForTest = Line.find(line_id)
		assert_match @LineForTest.content, new_content
	end

	test "should not edit when not admin user" do		
		log_in_as(@user_notadmin)
		line_id = @line.id
		old_content = @line.content
		new_content = "this line was edit"
		assert_no_difference 'Line.count' do
			patch :update, id: @line, line: {content: new_content, 
																			index: 41}
		end
		assert_redirected_to root_path
		#TODO add error flash
		@LineForTest = Line.find(line_id)
		assert_match @LineForTest.content, old_content
	end

	test "should not edit when not login" do		
		line_id = @line.id
		old_content = @line.content
		new_content = "this line was edit"
		assert_no_difference 'Line.count' do
			patch :update, id: @line, line: {content: new_content, 
																			index: 41}
		end
		assert_redirected_to login_path
		#TODO add error flash
		@LineForTest = Line.find(line_id)
		assert_match @LineForTest.content, old_content
	end

#	test "show line as admin user" do		
#		log_in_as(@user_admin)
#		get :show, id: @line
#		assert_select 'a', text: 'delete', count: 1
#		assert_select 'a', text: 'edit', count: 1
#		assert_select 'h1', text: 'GIMP', count: 1		
#		assert_select 'h2 div#version', text: 'Vession: 1.1', count: 1		
#		assert_select 'h2 div#os', text: 'Operation System: linux', count: 1		
#	end
	
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
