require 'test_helper'

class OperatingSystemsTest < ActionDispatch::IntegrationTest
	
	def setup
		@user = users(:michael)
		@user_notAdmin = users(:archer)
	end
	
	test "instalation interface for admin user" do
		log_in_as(@user)
		get root_path
		assert_select 'div.pagination'
		assert_select 'input[type=submit]'
		get operating_systems_path
		@amount = OperatingSystem.count
		assert_select 'a', text: 'delete', count: @amount
		# Invalid submission
		assert_no_difference 'OperatingSystem.count' do
			post operating_systems_path, operating_system: { name: "", version: "1.1" }
		end
		assert_select 'div#error_explanation'
		# Valid submission
		assert_difference 'OperatingSystem.count' do
			post operating_systems_path, operating_system: { name: "linux", version: "1.1" }
		end
		#Assert_redirected_to instalation_path
		follow_redirect!
		assert_match "linux", response.body
		assert_select 'a', text: 'delete', count: @amount + 1
		#Delete a post.
		assert_select 'a', text: 'delete'
		first_operating_system = OperatingSystem.paginate(page: 1).first
		assert_difference 'OperatingSystem.count', -1 do
			delete operating_system_path(first_operating_system)
		end
		get operating_systems_path
		assert_select 'a', text: 'delete', count: @amount
	end

end
