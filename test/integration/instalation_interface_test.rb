require 'test_helper'

class InstalationInterfaceTest < ActionDispatch::IntegrationTest
  def setup
		@user = users(:michael)
		@user_notAdmin = users(:archer)
	end
	
	test "instalation interface for admin user" do
		log_in_as(@user)
		get root_path
		assert_select 'div.pagination'
		assert_select 'input[type=submit]'
		get instalations_path
		assert_select 'a', text: 'delete', count: 2
		# Invalid submission
		assert_no_difference 'Instalation.count' do
			post instalations_path, instalation: { name: "", version: "1.1", os: "ubuntu" }
		end
		assert_select 'div#error_explanation'
		# Valid submission
		assert_difference 'Instalation.count', 1 do
			post instalations_path, instalation: { name: "gimpp", version: "1.1", os: "ubuntu" }
		end
		#Assert_redirected_to instalation_path
		follow_redirect!
		assert_match "gimpp", response.body
		assert_select 'a', text: 'delete', count: 3
		#Delete a post.
		assert_select 'a', text: 'delete'
		first_instalation = Instalation.paginate(page: 1).first
		assert_difference 'Instalation.count', -1 do
			delete instalation_path(first_instalation)
		end
		# Visit a different user.
		get instalations_path
		assert_select 'a', text: 'delete', count: 2
	end
	
	test "instalation interface for not admin user" do
		log_in_as(@user_notAdmin)
		get root_path
		assert_select 'div.pagination'
		assert_select 'input[type=submit]'
		get instalations_path		
		assert_select 'a', text: 'delete', count: 0
		# Invalid submission
		assert_no_difference 'Instalation.count' do
			post instalations_path, instalation: { name: "", version: "1.1", os: "ubuntu" }
		end
		assert_select 'div#error_explanation'
		# Valid submission
		assert_difference 'Instalation.count', 1 do
			post instalations_path, instalation: { name: "gimpp", version: "1.1", os: "ubuntu" }
		end
		#Assert_redirected_to instalation_path
		follow_redirect!
		assert_match "gimpp", response.body
		#Delete a post.
		assert_select 'a', text: 'delete', count: 0
		first_instalation = Instalation.paginate(page: 1).first
		assert_no_difference 'Instalation.count' do
			delete instalation_path(first_instalation)
		end
		# Visit a different user.
		get instalations_path
		assert_select 'a', text: 'delete', count: 0
	end
	
	test "instalation sidebar count" do
		log_in_as(@user)
		get instalations_path
		assert_match "#{Instalation.count} instalations", response.body
		first_instalation = Instalation.paginate(page: 1).first
		delete instalation_path(first_instalation)
		first_instalation = Instalation.paginate(page: 1).first
		delete instalation_path(first_instalation)
		get instalations_path
		assert_match "0 instalations", response.body
		Instalation.create!(name: "gimp1", version: "1.1", os: "ubuntu")
		get instalations_path
		assert_match "1 instalation", response.body
		Instalation.create!(name: "gimp2", version: "1.1", os: "ubuntu")
		get instalations_path
		assert_match "2 instalations", response.body
	end
end