require 'test_helper'

class StepIntegrationTest < ActionDispatch::IntegrationTest
		
	def setup
		@instalation             = Instalation.first
		#@instalation3            = Instalation.all[2]
		@instalation3            = instalations(:gimp)
		@instalations            = Instalation.all
		@number_of_instalation   = Instalation.count
		#@lines                   = Line.all
		@line1                   = lines(:l1)
		@line2                   = Line.all[1]
		@line3                   = Line.all[2]
		@lines                   = @instalation.hasline.paginate(page: 1)
		@number_of_lines         = @lines.count	
		@steps                   = Step.all
		@user_admin              = users(:michael)
		@user_notadmin           = users(:archer)		
	end
	
	
	test "add/remove line from instalation" do
		log_in_as(@user_admin)
		@instalation3.user_id = @user_admin.id
		@instalation3.save
		get instalation_path(@instalation3)
		#assert_match "0 microposts", response.body
		@instalation3.addline(@line1,0)
		assert_difference 'Line.count' do
			post lines_path, line: { id: 0, content: "fsdf" , index: 111}
		end
		#TODO good test!!!
		#assert_difference 'Step.count' do
		#	post steps_path, step: { instalation_id: 2, line_id: 0, order: 0 }
		#end

		#assert_match @line1[:content], response.body
		#assert_match @line1[:index], response.body
	end
	
	
	
	
	
	
end