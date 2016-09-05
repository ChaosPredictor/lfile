require 'test_helper'

class InstallationInterfaceTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:michael)
		@user_notAdmin = users(:archer)
	end
	
	test "installation interface for admin user" do
		log_in_as(@user)
		get root_path
		assert_select 'div.pagination'
		assert_select 'input[type=submit]'
		get installations_path
		@amount = Installation.count
		assert_select 'a', text: 'delete', count: @amount
		# Invalid submission
		assert_no_difference 'Installation.count' do
			post installations_path, installation: { name: "", version: "1.1", os: "ubuntu", source_link: ".com" }
		end
		assert_select 'div#error_explanation'
		# Valid submission
		assert_difference 'Installation.count', 1 do
			post installations_path, installation: { name: "gimpp", version: "1.1", os: "ubuntu", source_link: "gimpp.com" }
		end
		#Assert_redirected_to installation_path
		follow_redirect!
		assert_match "gimpp", response.body
		assert_select 'a', text: 'delete', count: @amount + 1
		#Delete a post.
		assert_select 'a', text: 'delete'
		first_installation = Installation.paginate(page: 1).first
		assert_difference 'Installation.count', -1 do
			delete installation_path(first_installation)
		end
		get installations_path
		assert_select 'a', text: 'delete', count: @amount
	end
	
	test "installation interface for not admin user" do
		log_in_as(@user_notAdmin)
		get root_path
		assert_select 'div.pagination'
		assert_select 'input[type=submit]'
		get installations_path		
		assert_select 'a', text: 'delete', count: 0
		# Invalid submission
		assert_no_difference 'Installation.count' do
			post installations_path, installation: { name: "", version: "1.1", os: "ubuntu", source_link: "gimpp.com" }
		end
		assert_select 'div#error_explanation'
		# Valid submission
		assert_difference 'Installation.count', 1 do
			post installations_path, installation: { name: "gimpp", version: "1.1", os: "ubuntu", source_link: "gimpp.com" }
		end
		#Assert_redirected_to installation_path
		follow_redirect!
		assert_match "gimpp", response.body
		#Delete a post.
		assert_select 'a', text: 'delete', count: 0
		first_installation = Installation.paginate(page: 1).first
		assert_no_difference 'Installation.count' do
			delete installation_path(first_installation)
		end
		get installations_path
		assert_select 'a', text: 'delete', count: 0
	end
	
	test "installation sidebar count" do
		log_in_as(@user)
		get installations_path
		assert_match "#{Installation.count} installations", response.body
		first_installation = Installation.paginate(page: 1).first
		while first_installation
			delete installation_path(first_installation)
			first_installation = Installation.paginate(page: 1).first
		end
		get installations_path
		assert_match "0 installations", response.body
		Installation.create!(name: "gimp1", version: "1.1", os: "ubuntu", source_link: "gimp1.com", user_id: 1)
		get installations_path
		assert_match "1 installation", response.body
		Installation.create!(name: "gimp2", version: "1.1", os: "ubuntu", source_link: "gimp2.com", user_id: 1)
		get installations_path
		assert_match "2 installations", response.body
	end
end