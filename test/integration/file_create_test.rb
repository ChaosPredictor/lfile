require 'test_helper'
#require 'rspec'

class FileCreateTest < ActionDispatch::IntegrationTest
	
	test "file created" do
		visit "/createfile"
		assert page.has_no_checked_field?('_instalations_15041760_torun')
		check('_instalations_15041760_torun')
		assert page.has_checked_field?('_instalations_15041760_torun')
		uncheck('_instalations_15041760_torun')
		assert page.has_no_checked_field?('_instalations_15041760_torun')

		
	end
end