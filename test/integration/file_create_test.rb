class FileCreateTest < ActionDispatch::IntegrationTest
	
	test "check uncheck checkbox" do
		visit "/createfile"
		assert page.has_no_checked_field?('_installations_15041760_torun')
		check('_installations_15041760_torun')
		assert page.has_checked_field?('_installations_15041760_torun')
		uncheck('_installations_15041760_torun')
		assert page.has_no_checked_field?('_installations_15041760_torun')
	end
	
	test "file created" do
		get createfile_path
		visit "/createfile"
		check('_installations_15041760_torun')
		click_on "create file"
	end
	
end