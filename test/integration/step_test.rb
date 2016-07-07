require 'test_helper'

class StepIntegrationTest < ActionDispatch::IntegrationTest
		
	def setup
		@instalation             = Instalation.first
		@instalations            = Instalation.all
		@number_of_instalation   = Instalation.count
		@line                    = Line.first
		@lines                   = @instalation.hasline.paginate(page: 1)
		@number_of_lines         = @lines.count	
		@user_admin              = users(:michael)
		@user_notadmin           = users(:archer)		
	end
	
	
	test "add/remove line from instalation" do
		log_in_as(@user_admin)
		get instalation_path(@instalation)
		#page.find(:value => "Add line").trigger('click') 
		#response.find(:value => "Add line").trigger('click') 
		#click_button "Add line"
		click_button("Add line")
	end
	
	
	
	
	
	
end