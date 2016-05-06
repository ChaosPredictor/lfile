require 'test_helper'
class ApplicationHelperTest < ActionView::TestCase
	test "full title helper" do
		assert_equal full_title, 					'Linux Apps Installer'
		assert_equal full_title("Help"),	'Help | Linux Apps Installer'
		assert_equal full_title("Contact"),	'Contact | Linux Apps Installer'
	end
end