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
		@amount = Instalation.count
		assert_select 'a', text: 'delete', count: @amount
		# Invalid submission
		assert_no_difference 'Instalation.count' do
			post instalations_path, instalation: { name: "", version: "1.1", os: "ubuntu", source_link: ".com" }
		end
		assert_select 'div#error_explanation'
		# Valid submission
		assert_difference 'Instalation.count', 1 do
			post instalations_path, instalation: { name: "gimpp", version: "1.1", os: "ubuntu", source_link: "gimpp.com", user_id: 1 }
		end
		#Assert_redirected_to instalation_path
		follow_redirect!
		assert_match "gimpp", response.body
		assert_select 'a', text: 'delete', count: @amount + 1
		#Delete a post.
		assert_select 'a', text: 'delete'
		first_instalation = Instalation.paginate(page: 1).first
		assert_difference 'Instalation.count', -1 do
			delete instalation_path(first_instalation)
		end
		get instalations_path
		assert_select 'a', text: 'delete', count: @amount
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
			post instalations_path, instalation: { name: "", version: "1.1", os: "ubuntu", source_link: "", user_id: 1 }
		end
		assert_select 'div#error_explanation'
		# Valid submission
		assert_difference 'Instalation.count', 1 do
			post instalations_path, instalation: { name: "gimpp", version: "1.1", os: "ubuntu", source_link: "gimpp.com", user_id: 1 }
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
		get instalations_path
		assert_select 'a', text: 'delete', count: 0
	end
	
	test "instalation sidebar count" do
		log_in_as(@user)
		get instalations_path
		assert_match "#{Instalation.count} instalations", response.body
		first_instalation = Instalation.paginate(page: 1).first
		while first_instalation
			delete instalation_path(first_instalation)
			first_instalation = Instalation.paginate(page: 1).first
		end
		get instalations_path
		assert_match "0 instalations", response.body
		Instalation.create!(name: "gimp1", version: "1.1", os: "ubuntu", source_link: "gimp1.com", user_id: 1)
		get instalations_path
		assert_match "1 instalation", response.body
		Instalation.create!(name: "gimp2", version: "1.1", os: "ubuntu", source_link: "gimp2.com", user_id: 1)
		get instalations_path
		assert_match "2 instalations", response.body
	end
end