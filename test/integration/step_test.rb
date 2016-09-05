require 'test_helper'

class StepIntegrationTest < ActionDispatch::IntegrationTest
		
	def setup
		@installation             = Installation.first
		#@installation3            = Installation.all[2]
		@installation3            = installations(:gimp)
		@installations            = Installation.all
		@number_of_installation   = Installation.count
		#@lines                   = Line.all
		@line1                   = lines(:l1)
		@line2                   = Line.all[1]
		@line3                   = Line.all[2]
		@lines                   = @installation.hasline.paginate(page: 1)
		@number_of_lines         = @lines.count	
		@steps                   = Step.all
		@user_admin              = users(:michael)
		@user_notadmin           = users(:archer)		
	end
	
	
	test "add/remove line from installation" do
		log_in_as(@user_admin)
		@installation3.user_id = @user_admin.id
		@installation3.save
		get installation_path(@installation3)
		#assert_match "0 microposts", response.body
		@installation3.addline(@line1,0)
		assert_difference 'Line.count' do
			post lines_path, line: { id: 0, content: "fsdf" , index: 111}
		end
		#TODO good test!!!
		#assert_difference 'Step.count' do
		#	post steps_path, step: { installation_id: 2, line_id: 0, order: 0 }
		#end

		#assert_match @line1[:content], response.body
		#assert_match @line1[:index], response.body
	end
	
	
	
	
	
	
end